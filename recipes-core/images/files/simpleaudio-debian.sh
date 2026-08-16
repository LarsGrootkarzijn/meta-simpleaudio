#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MACHINE_PATH="$(dirname "$SCRIPT_DIR")/../../conf/machine"

PASSWORD=SambaPig

PACKAGES="nano,sudo,gpiod,udev,systemd-timesyncd,systemd-resolved,systemd-sysv,ca-certificates,apt,netbase,iproute2,iputils-ping,openssh-server,alsa-utils"

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    echo "Please run with: sudo $0"
    exit 1
fi

echo "== Installing build dependencies =="
apt-get update
apt-get install -y mmdebstrap squashfs-tools

REPO_KEY="$SCRIPT_DIR/repo-key.asc"

if [[ ! -f "$REPO_KEY" ]]; then
    echo "== Downloading custom repository key =="
    curl -fsSL \
        https://repo.grootkarzijn.com/repo-key.asc \
        -o "$REPO_KEY"
fi

for file in "$MACHINE_PATH"/*; do
    [[ -f "$file" ]] || continue

    DEBIAN_RELEASE=$(grep -E '^DEBIAN_RELEASE[[:space:]]*=' "$file" \
                    | cut -d'=' -f2 \
                    | sed 's/^ *//;s/ *$//' \
                    | tr -d '"')

    DEBIAN_ARCH=$(grep -E '^DEBIAN_ARCH[[:space:]]*=' "$file" \
                | cut -d'=' -f2 \
                | sed 's/^ *//;s/ *$//' \
                | tr -d '"')

    DEBIAN_MIRROR=$(grep -E '^DEBIAN_MIRROR[[:space:]]*=' "$file" \
                    | cut -d'=' -f2 \
                    | sed 's/^ *//;s/ *$//' \
                    | tr -d '"')

    MACHINE=$(grep -E '^MACHINE[[:space:]]*=' "$file" \
                | cut -d'=' -f2 \
                | sed 's/^ *//;s/ *$//' \
                | tr -d '"')

    OUT="$SCRIPT_DIR/debian-${DEBIAN_RELEASE}-${MACHINE}.tar.gz"
    WORKDIR="$SCRIPT_DIR/build-rootfs-${MACHINE}"


    echo
    echo "============================================"
    echo "Building Debian rootfs"
    echo "MACHINE=$MACHINE"
    echo "DEBIAN_RELEASE=$DEBIAN_RELEASE"
    echo "DEBIAN_ARCH=$DEBIAN_ARCH"
    echo "DEBIAN_MIRROR=$DEBIAN_MIRROR"
    echo "Output: $OUT"
    echo "============================================"

    sleep 3

    rm -rf "$WORKDIR"
    mkdir -p "$WORKDIR"

    mmdebstrap \
      --arch=$DEBIAN_ARCH \
      --variant=minbase \
      --include=$PACKAGES \
      --components="main" \
      $DEBIAN_RELEASE \
      $WORKDIR/rootfs \
      $DEBIAN_MIRROR

    install -Dm644 "$REPO_KEY" "$WORKDIR/rootfs/usr/share/keyrings/grootkarzijn-archive-keyring.asc"

    cat > "$WORKDIR/rootfs/etc/apt/sources.list.d/grootkarzijn.sources" <<EOF
Types: deb
URIs: https://repo.grootkarzijn.com/dev/debian
Suites: trixie
Components: main
Signed-By: /usr/share/keyrings/grootkarzijn-archive-keyring.asc
EOF


    echo "root:${PASSWORD}" | chroot "$WORKDIR/rootfs" chpasswd

    chroot "$WORKDIR/rootfs" useradd \
        --create-home \
        --shell /bin/bash \
        hifiberry

    echo "hifiberry:${PASSWORD}" | chroot "$WORKDIR/rootfs" chpasswd

    chroot "$WORKDIR/rootfs" usermod -aG sudo hifiberry
    chroot "$WORKDIR/rootfs" usermod -aG audio hifiberry

    printf '%s\n' "hifiberry" > "$WORKDIR/rootfs/etc/hifiberry.user"
    
    chroot "$WORKDIR/rootfs" rm /etc/hostname
    chroot "$WORKDIR/rootfs" rm -f /etc/ssh/ssh_host_*

    chroot "$WORKDIR/rootfs" apt clean

    chroot "$WORKDIR/rootfs" sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    
    systemctl --root="$WORKDIR/rootfs" enable ssh
    systemctl --root="$WORKDIR/rootfs" enable systemd-networkd

    rm -f "$WORKDIR/rootfs/etc/resolv.conf"

    ln -s /run/systemd/resolve/stub-resolv.conf "$WORKDIR/rootfs/etc/resolv.conf"

    systemctl --root="$WORKDIR/rootfs" enable systemd-resolved
    systemctl --root="$WORKDIR/rootfs" enable systemd-timesyncd

    chroot "$WORKDIR/rootfs" truncate -s 0 /etc/machine-id

    for mountpoint in \
        "$WORKDIR/rootfs/dev/pts" \
        "$WORKDIR/rootfs/dev" \
        "$WORKDIR/rootfs/proc" \
        "$WORKDIR/rootfs/sys" \
        "$WORKDIR/rootfs/run"; do

        if mountpoint -q "$mountpoint" 2>/dev/null; then
            umount -l "$mountpoint" || true
        fi
    done

    rm -rf "$WORKDIR/rootfs/run/"*
    rm -rf "$WORKDIR/rootfs/tmp/"*
    rm -rf "$WORKDIR/rootfs/var/tmp/"*

    mkdir -p "$WORKDIR/rootfs/run" \
        "$WORKDIR/rootfs/tmp" \
        "$WORKDIR/rootfs/var/tmp"

    chmod 1777 "$WORKDIR/rootfs/tmp" \
        "$WORKDIR/rootfs/var/tmp"

    tar --numeric-owner \
        -C "$WORKDIR/rootfs" \
        -czf "$OUT" .

    echo "Clean up"

    rm -rf "$WORKDIR"

    echo
    echo "Build complete: $OUT"
done


sudo systemctl disable ble-provisioning.service