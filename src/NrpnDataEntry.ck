public class NrpnDataEntry extends Nrpn {
    function NrpnData fromCc(MidiMsg in) {
        return Nrpn.lastValue.toMidi(channelNumber(in.data1), lastValue.scale(in.data3));
    }
    function void setLastValue(Nrpn value) {
        // noop, since data entry is not an actual parameter
    }
}
