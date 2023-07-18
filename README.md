Source: https://nebu.substack.com/p/linux-pulseaudio-how-to-stream-audio

Just run `setup.sh`, select your audio input and output, and the script will
create loopbacks. Pipe your application's playback into V1AppOutput and pipe
V2Mixed into Discord's recording input.

Run `teardown.sh` to clean up.
