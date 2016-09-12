public class NrpnMemory extends Nrpn {
    0 => int currentValue;
    function NrpnData fromCc(MidiMsg in) {
        (currentValue + 1) % (maxValue + 1) => currentValue;
        currentValue => in.data3;
        return toMidi(channelNumber(in.data1), scale(in.data3));
    }
    function static NrpnMemory define(int param, int maximumValue) {
        NrpnMemory msg;
        msb(param) => msg.paramMsb;
        lsb(param) => msg.paramLsb;
        maximumValue => msg.maxValue;
        return msg;
    }
}
