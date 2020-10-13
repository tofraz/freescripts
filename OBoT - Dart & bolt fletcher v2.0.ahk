;This is Orange' awesome AHK dart/bolt fletcher!
Gui, Add, Button, x12 y9 w100 h50 , Resize BlueStacks
Gui, Add, Button, x132 y9 w100 h50 , STOP SCRIPT
Gui, Add, Button, x12 y69 w220 h40 , START SCRIPT
Gui, Add, Text, x47 y109 w150 h20 , OBoT - Dart/Bolt Fletcher v2.0
Gui, Show, x126 y87 h131 w249, OBoT - Dart/Bolt Fletcher v2.0
return

GuiClose:
GuiEscape:
ExitApp
return

ButtonResizeBlueStacks:
Shift & F1:: ; Set the window size 
WinMove, BlueStacks,, , , 980, 600 ; resize BlueStacks
sleep, 30
MsgBox, 4096, Orangebot, BlueStacks has been resized to the required window size. ; Message box
; WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]
return

Shift & F2:: ;Set view model
Controlclick, x734 y70, BlueStacks,,,, NA ; Click compass
Sleep, 30
SetControlDelay -1
ControlClick, x736 y72, BlueStacks,,,, NA; clickcompass
sleep 100
            Controlclick, x482 y289, BlueStacks,, WheelUp, 1, NA ; wheel up

ControlClick, x725 y112, BlueStacks,,,, NA ; FOR SOME REASON THIS IS NECESSARY TO DO BIRDSEYE
return

ButtonSTOPSCRIPT: ; STOP THE SCRIPT
F12::reload
return


ButtonSTARTSCRIPT: ; START THE SCRIPT
Tab::
start:
Random, minrand, 25, 75
Random, smallrand, 55, 85
Random, midrand, 90, 130
Random, bigrand, 110, 220
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x696 y278, BlueStacks,,,, NA ; Click first inventory slot

Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x736 y277, BlueStacks,,,, NA ; Click second inventory slot
Goto, start
return