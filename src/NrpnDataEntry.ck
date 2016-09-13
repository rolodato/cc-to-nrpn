public class NrpnDataEntry extends Nrpn {
	function NrpnData fromCc(MidiMsg in) {
		if (Nrpn.lastValue != null) {
			return Nrpn.lastValue.toMidi(channelNumber(in.data1), lastValue.scale(in.data3));
		} else {
			MidiMsg data[0];
			return NrpnData.create(data);
		}

	}
	function void setLastValue(Nrpn value) {
		// noop, since data entry is not an actual parameter
	}
}
