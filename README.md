# CSGO Arch Linux Scripts


## GameNotStartingFix Script

**Currently borked**

Script which checks for errors relating to known issues with CSGO.

Libtcmalloc segfault:
https://github.com/ValveSoftware/csgo-osx-linux/issues/2659#issuecomment-1081135949

Panorama video segfault:
https://github.com/ValveSoftware/csgo-osx-linux/issues/2659#issuecomment-934357559

1. Place in your CSGO directory

1. Do `chmod +x GameNotStartingFix-V1.sh` to make it executable.

1. `./GameNotStartingFix-V1.sh` to execute the script.

If either of these are workarounds are applied to your game, you should add `-novid -nojoy` to your CSGO launch parameters.

Can this cause VAC? I have no idea!! :)

Worst case you get VAC'd and have to create a support ticket to explain you used fixes found on the official CSGO Linux/MacOS GitHub.

Verifying game files through Steam should undo the changes made by both of these workarounds.

## GameLaunchLoop Script

Essentially just keeps trying to launch CSGO until it doesn't crash.

1. Do `chmod +x GameLaunchLoop.sh` to make it executable.

1. `./GameLaunchLoop.sh` to execute the script.

This can be used as another workaround the issues from the GitHub links above but it's not for the impatient (Waiting is for Windows users*).

\* As is CSGO starting when you click the play button :////
