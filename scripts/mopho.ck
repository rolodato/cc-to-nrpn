int inDevice;
int outDevice;
if (me.args()) {
    me.arg(0) => Std.atoi => inDevice;
    me.arg(1) => Std.atoi => outDevice;
} else {
    <<<"usage: chuck mopho.ck:InDeviceNumber:OutDeviceNumber">>>;
    <<<"see chuck --probe for device numbers">>>;
    me.exit();
}

MidiIn midiIn;
MidiOut midiOut;
MidiMsg msg;

if (!midiIn.open(inDevice)) {
    <<<"could not open MIDI input device">>>;
    me.exit();
}
if (!midiOut.open(outDevice)) {
    <<<"could not open MIDI output device">>>;
    me.exit();
}

<<<"listening for MIDI input...">>>;

Nrpn @ mapping[128];
for (0 => int i; i < mapping.cap(); i++) {
    null => mapping[i];
}
// oscillator 1
Nrpn.create(0, 120) @=> mapping[20];
Nrpn.create(1, 100) @=> mapping[21];
Nrpn.create(2, 103) @=> mapping[22];
Nrpn.create(3, 127) @=> mapping[23];
Nrpn.create(114, 127) @=> mapping[30];
// oscillator 2
Nrpn.create(5, 120) @=> mapping[24];
Nrpn.create(6, 100) @=> mapping[25];
Nrpn.create(7, 103) @=> mapping[26];
Nrpn.create(8, 127) @=> mapping[27];
Nrpn.create(115, 127) @=> mapping[31];
// misc oscillator options
Nrpn.create(13, 127) @=> mapping[28];
Nrpn.create(14, 127) @=> mapping[29];
Nrpn.create(12, 5) @=> mapping[33];
Nrpn.create(93, 12) @=> mapping[34];
// filter envelope
Nrpn.create(23, 127) @=> mapping[109];
Nrpn.create(24, 127) @=> mapping[110];
Nrpn.create(25, 127) @=> mapping[111];
Nrpn.create(26, 127) @=> mapping[112];
Nrpn.create(17, 127) @=> mapping[104];
Nrpn.create(18, 127) @=> mapping[105];
Nrpn.create(20, 254) @=> mapping[106];
Nrpn.create(21, 127) @=> mapping[107];
Nrpn.create(22, 127) @=> mapping[108];
// amplifier envelope
Nrpn.create(31, 127) @=> mapping[115];
Nrpn.create(30, 127) @=> mapping[116];
Nrpn.create(33, 127) @=> mapping[118];
Nrpn.create(34, 127) @=> mapping[119];
Nrpn.create(35, 127) @=> mapping[120];
Nrpn.create(36, 127) @=> mapping[122];
// filter mode
Nrpn.create(19, 1) @=> mapping[124];
// oscillator sync
Nrpn.create(10, 1) @=> mapping[125];
// mod wheel amount
Nrpn.create(81, 254) @=> mapping[126];
// mod wheel destination
NrpnMemory.define(82, 46) @=> mapping[18];
// velocity amount
Nrpn.create(87, 254) @=> mapping[127];
// velocity destination
Nrpn.create(88, 46) @=> mapping[17];
// arpeggiator toggle
Nrpn.create(100, 1) @=> mapping[16];
// sequencer toggle
Nrpn.create(101, 1) @=> mapping[15];
// data entry
new NrpnDataEntry @=> mapping[19];

// Increment/decrement current parameter
// All parameters have to be sent via NRPN even if they are supported via CC
new NrpnIncrement @=> mapping[101];
new NrpnDecrement @=> mapping[100];

while (true) {
    midiIn => now;
    while (midiIn.recv(msg)) {
        if (mapping[msg.data2] != null) {
            mapping[msg.data2].setLastValue(mapping[msg.data2]);
            mapping[msg.data2].fromCc(msg).send(midiOut);
        }
    }
}
