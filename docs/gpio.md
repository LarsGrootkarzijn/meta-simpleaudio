# GPIO References

This document describes the GPIO configuration script and pin usage.

| GPIO Chip | GPIO (0-7) | Type   | Description / Standard | Default Value | Kernel Name | GPIO Chip Kernel |
|-----------|------------|--------|----------------------|---------------|------------|----------------|
| gpiochip6 | 0          | Input  | Button on the side   | 0             | side-button    | pca9554@20      |
| gpiochip6 | 1          | Input  | Unknown                | 0             | unknown    | pca9554@20      |
| gpiochip6 | 2          | Output | White LED brightness | 0             | white-lead    | pca9554@20      |
| gpiochip6 | 3          | Output | Soundcard Clock switch | 0           | soundcard-clk-1    | pca9554@20      |
| gpiochip6 | 4          | Output | Soundcard Clock switch | 0           | soundcard-clk-2    | pca9554@20      |
| gpiochip6 | 5          | Output | Soundcard            | 0             | soundcard    | pca9554@20      |
| gpiochip6 | 6          | Input  | Unknown              | 0             | unknown   | pca9554@20      |
| gpiochip6 | 7          | Output | Rear line            | 0             | line-out    | pca9554@22      |
| gpiochip5 | 0          | Output | Headphone            | 0             | headphone    | pca9554@22      |
| gpiochip5 | 1          | Output | amplifier            | 0             | amplifier    | pca9554@22      |
| gpiochip5 | 2          | Output | Red LED              | 0             | red-led    | pca9554@22      |
| gpiochip5 | 3          | Output | Green LED blink      | 0             | green-led-blink    | pca9554@22      |
| gpiochip5 | 4          | Output | Green LED            | 0             | green-led    | pca9554@22      |
| gpiochip5 | 5          | Input  | Ethernet PHY         | 0             | ethernet-phy    | pca9554@22      |
| gpiochip5 | 6          | Input  | Unknown              | 0             | unknown    | pca9554@22      |
| gpiochip5 | 7          | Input  | Unknown              | 0             | unknown    | pca9554@23      |
| gpiochip4 | 0          | Input  | Amp input            | 0             | amplifier-in    | pca9554@23      |
| gpiochip4 | 1          | Input  | Input                | 0             | unknown    | pca9554@23      |
| gpiochip4 | 2          | Input  | Headphone front input| 0             | headphone-in    | pca9554@23      |
| gpiochip4 | 3          | Input  | Line input front     | 0             | line-front-in    | pca9554@23      |
| gpiochip4 | 4          | Input  | Unknown                | 0             | unknown    | pca9554@23      |
| gpiochip4 | 5          | Input  | Unknown                | 0             | unknown    | pca9554@23      |
| gpiochip4 | 6          | Input  | Unknown                | 0             | unknown    | pca9554@23      |
| gpiochip4 | 7          | Input  | Unknown                | 0             | unknown    | pca9554@23      |