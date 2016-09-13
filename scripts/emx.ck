int inDevice;
int outDevice;
if (me.args()) {
    me.arg(0) => Std.atoi => inDevice;
    me.arg(1) => Std.atoi => outDevice;
} else {
    <<<"usage: chuck emx.ck:InDeviceNumber:OutDeviceNumber">>>;
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
// drum1 part
Nrpn.create(0x09, 0x20, 207) @=> mapping[50];       // wave
NrpnCoarse.define(0x09, 0x21, 127) @=> mapping[51]; // pitch
NrpnCoarse.define(0x09, 0x27, 127) @=> mapping[52]; // level
NrpnCoarse.define(0x09, 0x28, 127) @=> mapping[53]; // pan
NrpnCoarse.define(0x09, 0x2b, 127) @=> mapping[54]; // roll
NrpnCoarse.define(0x09, 0x2d, 127) @=> mapping[55]; // FX send

// drum2 part
Nrpn.create(0x09, 0x40, 207) @=> mapping[56];
NrpnCoarse.define(0x09, 0x41, 127) @=> mapping[57];
NrpnCoarse.define(0x09, 0x47, 127) @=> mapping[58];
NrpnCoarse.define(0x09, 0x48, 127) @=> mapping[59];
NrpnCoarse.define(0x09, 0x4b, 127) @=> mapping[60];
NrpnCoarse.define(0x09, 0x4d, 127) @=> mapping[61];

// drum3 part
Nrpn.create(0x09, 0x60, 207) @=> mapping[62];
NrpnCoarse.define(0x09, 0x61, 127) @=> mapping[63];
NrpnCoarse.define(0x09, 0x67, 127) @=> mapping[64];
NrpnCoarse.define(0x09, 0x68, 127) @=> mapping[65];
NrpnCoarse.define(0x09, 0x6b, 127) @=> mapping[66];
NrpnCoarse.define(0x09, 0x6d, 127) @=> mapping[67];

// drum4 part
Nrpn.create(0x0a, 0x00, 207) @=> mapping[68];
NrpnCoarse.define(0x0a, 0x01, 127) @=> mapping[69];
NrpnCoarse.define(0x0a, 0x07, 127) @=> mapping[70];
NrpnCoarse.define(0x0a, 0x08, 127) @=> mapping[71];
NrpnCoarse.define(0x0a, 0x0b, 127) @=> mapping[72];
NrpnCoarse.define(0x0a, 0x0d, 127) @=> mapping[73];

// drum5 part
Nrpn.create(0x0a, 0x20, 207) @=> mapping[74];
NrpnCoarse.define(0x0a, 0x21, 127) @=> mapping[75];
NrpnCoarse.define(0x0a, 0x27, 127) @=> mapping[76];
NrpnCoarse.define(0x0a, 0x28, 127) @=> mapping[77];
NrpnCoarse.define(0x0a, 0x2b, 127) @=> mapping[78];
NrpnCoarse.define(0x0a, 0x2d, 127) @=> mapping[79];

// drum6A part
Nrpn.create(0x0a, 0x40, 207) @=> mapping[80];
NrpnCoarse.define(0x0a, 0x41, 127) @=> mapping[81];
NrpnCoarse.define(0x0a, 0x47, 127) @=> mapping[82];
NrpnCoarse.define(0x0a, 0x48, 127) @=> mapping[83];
NrpnCoarse.define(0x0a, 0x4b, 127) @=> mapping[84];
NrpnCoarse.define(0x0a, 0x4d, 127) @=> mapping[85];

// drum6B part
Nrpn.create(0x0a, 0x60, 207) @=> mapping[86];
NrpnCoarse.define(0x0a, 0x61, 127) @=> mapping[87];
NrpnCoarse.define(0x0a, 0x67, 127) @=> mapping[88];
NrpnCoarse.define(0x0a, 0x68, 127) @=> mapping[89];
NrpnCoarse.define(0x0a, 0x6b, 127) @=> mapping[90];
NrpnCoarse.define(0x0a, 0x6d, 127) @=> mapping[91];

// drum7A part
Nrpn.create(0x0b, 0x00, 207) @=> mapping[92];
NrpnCoarse.define(0x0a, 0x01, 127) @=> mapping[93];
NrpnCoarse.define(0x0a, 0x07, 127) @=> mapping[94];
NrpnCoarse.define(0x0a, 0x08, 127) @=> mapping[95];
NrpnCoarse.define(0x0a, 0x0b, 127) @=> mapping[96];
NrpnCoarse.define(0x0a, 0x0d, 127) @=> mapping[97];

while (true) {
    midiIn => now;
    while (midiIn.recv(msg)) {
        if (mapping[msg.data2] != null) {
            mapping[msg.data2].setLastValue(mapping[msg.data2]);
            mapping[msg.data2].fromCc(msg).send(midiOut);
        }
    }
}
