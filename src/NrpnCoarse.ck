public class NrpnCoarse extends Nrpn {

    function static NrpnCoarse define(int msb, int lsb, int maximumValue) {
        NrpnCoarse msg;
        msb => msg.paramMsb;
        lsb => msg.paramLsb;
        maximumValue => msg.maxValue;
        return msg;
    }

    function NrpnData toMidi(int channel, int value) {
        MidiMsg msg1;
        MidiMsg msg2;
        MidiMsg msg3;
        MidiMsg msg4;
        controlChange(channel) => int status;

        status => msg1.data1;
        0x63 => msg1.data2;
        paramMsb => msg1.data3;

        status => msg2.data1;
        0x62 => msg2.data2;
        paramLsb => msg2.data3;

        status => msg3.data1;
        0x6 => msg3.data2;
        lsb(value) => msg3.data3;

        return NrpnData.create([msg1, msg2, msg3]);
    }
}
