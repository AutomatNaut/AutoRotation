# AutoRotation

# Prerequisites

BlueStacks https://www.bluestacks.com/ 

AutoHotKey https://www.autohotkey.com/ - Current Version

# Installation

Just need to have all of the files downloaded in the same folder.

In Bluestacks you will need to set up your hotkeys, see following for examples.  In Blue Stack go to Game Controls -> Advanced Editor and Import the Strike Force.cfg file.  This should set up all of the hotkeys:

![Hotkey Placement](images/hotkey1.PNG?raw=true "Hotkeys")

![Hotkey Placement](images/hotkey2.PNG?raw=true "Hotkeys")

When you are ready open blitz screen and select your last saved squad (i.e. 28/28).  Then run the appropriate script.  Either **fullBlitz** for one rotation, **fullBlitzOvernight** for 4 rotations in a row, or **RTALoop** to run Real-Time Arena matches.

# Optional Features
## Email Notificaiton 
I have the script email me when errors occur as well as a summary of the blitz rotation (Wins / Losses, Duration, Score before and after).  This is entirely optional, if you wish to remove it just remove or comment our all calls to the **sendEmailNotification** function 
