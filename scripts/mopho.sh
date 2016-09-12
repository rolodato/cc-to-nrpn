set -e
set -u

if [ "$#" -ne 2 ]; then
	echo "missing MIDI device numbers as parameters"
	exit 1
fi
INPUT=$1
OUTPUT=$2

cd `dirname $0`/../src/
chuck --loop &
sleep 1
CHUCK_PID=$!
chuck + import.ck
chuck + ../scripts/mopho.ck:${INPUT}:${OUTPUT}
wait $CHUCK_PID
