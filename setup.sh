#!/bin/bash
# (C) Lazula
# Distributed under GPLv3, see LICENSE

PS3="Select your microphone input: "
select s in $(pactl list sources | grep Name | grep input | cut -c8-)
do
  SOURCE=$s
  break
done

PS3="Select your speaker or headphone output: "
select s in $(pactl list sinks | grep Name | grep output | cut -c8-)
do
  SINK=$s
  break
done

# Create the mixers
pactl load-module module-null-sink sink_name=V1 sink_properties=device.description=V1AppOutput > modules.lst
pactl load-module module-null-sink sink_name=V2 sink_properties=device.description=V2Mixed >> modules.lst

# Create the loopbacks
pactl load-module module-loopback source=$SOURCE sink=V2 >> modules.lst
pactl load-module module-loopback source=V1.monitor sink=V2 >> modules.lst
pactl load-module module-loopback source=V1.monitor sink=$SINK >> modules.lst

echo "1. Open pavucontrol."
echo "2. Playback > Set your application's output to V1AppOutput."
echo "3. Recording > Set discord's (webrtc voiceengine) input to Monitor of V2Mixed."
echo ""
echo "To change the volume pushed to the microphone, adjust Loopback from Monitor of V1AppOutput on V2Mixed"
echo ""
echo "The created module numbers have been saved to modules.lst"
echo "Run teardown.sh to delete them. This should automatically reset settings to defaults."
