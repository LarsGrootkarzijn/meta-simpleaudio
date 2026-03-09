#!/usr/bin/env bash
set -euo pipefail

# CONFIG
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MACHINE_PATH="$(dirname "$SCRIPT_DIR")/../../conf/machine"

ROOT_PASSWORD=SambaPig

PACKAGES="systemd-sysv,ca-certificates,apt,netbase,iproute2,iputils-ping,openssh-server,alsa-utils,mpd,mpc"

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    echo "Please run with: sudo $0"
    exit 1
fi

echo "== Installing build dependencies =="
apt-get update
apt-get install -y mmdebstrap squashfs-tools

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


    tee "$WORKDIR/rootfs/etc/apt/apt.conf.d/01norecommend" >/dev/null <<EOF
                APT::Install-Recommends "0";
                APT::Install-Suggests "0";
EOF

    tee "$WORKDIR/rootfs/etc/dpkg/dpkg.cfg.d/01_nodoc" >/dev/null <<EOF
                    path-exclude=/usr/share/doc/*
                    path-exclude=/usr/share/man/*
                    path-exclude=/usr/share/locale/*
                    path-exclude=/usr/share/info/*
EOF

    sed -i 's/#Storage=.*/Storage=volatile/' "$WORKDIR/rootfs/etc/systemd/journald.conf"
    sed -i 's/#RuntimeMaxUse=.*/RuntimeMaxUse=16M/' "$WORKDIR/rootfs/etc/systemd/journald.conf"

    # Root wachtwoord
    echo "root:${ROOT_PASSWORD}" | chroot "$WORKDIR/rootfs" chpasswd

    # SSH enable
    chroot "$WORKDIR/rootfs" systemctl enable ssh

    # Cache schoonmaken
    chroot "$WORKDIR/rootfs" apt clean

    # Tarball maken
    tar --numeric-owner -C "$WORKDIR/rootfs" -cf "$OUT" .

    echo "Clean up"

    sudo rm -r $WORKDIR

    echo
    echo "Build complete: $OUT"
done
