# cc-to-nrpn

ChucK scripts to map incoming MIDI CC messages to device-specific NRPN.

## Example

[`mopho.ck`](/scripts/mopho.ck) assumes you are using a [Novation Launch Control XL](https://us.novationmusic.com/launch/launch-control-xl) configured with the [corresponding mapping file](/mappings/launchcontrolxl-mopho.syx) in order to control a [Mopho](https://www.davesmithinstruments.com/product/mopho/) (only tested on desktop module version).

Use `chuck --probe` to find the IDs of your connected MIDI devices:

```
$ chuck --probe
[ ... ]
[chuck]: ------( chuck -- 2 MIDI inputs )------
[chuck]:     [0] : "JUNO-Gi"
[chuck]:     [1] : "Launch Control XL"
[chuck]:
[chuck]: ------( chuck -- 3 MIDI outputs )-----
[chuck]:     [0] : "JUNO-Gi"
[chuck]:     [1] : "Launch Control XL"
```

In this case I want to route input from the Launch Control XL (1) to the Mopho, which is connected to the JUNO-Gi's MIDI output (0).

Run the following command, replacing the corresponding device numbers:

```
$ ./scripts/mopho.sh 1 0
```

Then move any pot or fader on the Launch Control XL, and you will see the corresponding value on the Mopho change.

## Supported features

* [Directly mapping a CC value to an NRPN value](https://github.com/rolodato/cc-to-nrpn/blob/master/src/Nrpn.ck).
  If the possible values for the NRPN have a different range than 0-127 they will be scaled accordingly, with precision loss if the range is larger
* Sending [NRPN Increment](https://github.com/rolodato/cc-to-nrpn/blob/master/src/NrpnIncrement.ck) and [NRPN Decrement](https://github.com/rolodato/cc-to-nrpn/blob/master/src/NrpnDecrement.ck) messages, which will increase/decrease the last changed parameter's value by 1
* [Cycling through an NRPN's possible values by repeatedly pressing the same button](https://github.com/rolodato/cc-to-nrpn/blob/master/src/NrpnMemory.ck)
* [Data entry control](https://github.com/rolodato/cc-to-nrpn/blob/master/src/Nrpn.ck#L70), which allows one CC to dynamically control the value of the last changed parameter
