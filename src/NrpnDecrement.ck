public class NrpnDecrement extends Nrpn {
    function NrpnData fromCc(MidiMsg in) {
        if (in.data3 == 0) {
            MidiMsg data[0];
            return NrpnData.create(data);
        }
        MidiMsg out;
        in.data1 => out.data1;
        0x61 => out.data2;
        0x0 => out.data3;
        return NrpnData.create([out]);
    }
}
