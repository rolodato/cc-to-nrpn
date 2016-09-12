if [ "$#" -ne 2 ]; then
	echo "missing MIDI device numbers as parameters"
	exit 1
fi
INPUT=$1
OUTPUT=$2

cd `dirname $0`/../src/
chuck NrpnData.ck Nrpn.ck NrpnDecrement.ck NrpnIncrement.ck NrpnMemory.ck ../scripts/mopho.ck:${INPUT}:${OUTPUT}
