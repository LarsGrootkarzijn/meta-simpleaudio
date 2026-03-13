# GPIO References

This document describes the GPIO configuration script and pin usage.

| GPIO Number | Direction | Default / Script Value | Function / Notes                     |
|------------:|:---------:|:--------------------:|-------------------------------------|
| 488        | Input     | 0                    | Side button                          |
| 490        | Output    | 0                    | White LED brightness                 |
| 491        | Output    | #                    | Reserved / used by kernel            |
| 492        | Output    | #                    | Reserved / used by kernel            |
| 493        | Output    | 1                    | Enable soundcard                     |
| 495        | Output    | 0                    | Line-out enable                      |
| 496        | Output    | 0                    | Headphone out enable                 |
| 497        | Output    | 0                    | Amplifier enable                     |
| 498        | Output    | 0                    | Red LED (disabled)                   |
| 499        | Output    | 0                    | Green LED blink control (disable)    |
| 500        | Output    | 1                    | Green LED enable                     |
| 501        | Input     | #                    | Ethernet PHY control (optional)      |
| 504        | Input     | 0                    | True if player has amplifier         |
| 506        | Input     | 0                    | Headphone plugged in                 |
| 507        | Input     | 0                    | Line front plugged in                |
 
> - GPIO numbers may change between kernel versions.    