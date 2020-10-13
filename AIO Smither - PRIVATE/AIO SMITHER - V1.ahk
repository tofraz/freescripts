FileCreateDir, Essentials
IniRead, ADesPosX, Essentials\Coordinates.ini, AIOSMITHACoord, AIOSMITHAXCord
IniRead, ADesPosY, Essentials\Coordinates.ini, AIOSMITHACoord, AIOSMITHAYCord
IniRead, BDesPosX, Essentials\Coordinates.ini, AIOSMITHBCoord, AIOSMITHBXCord
IniRead, BDesPosY, Essentials\Coordinates.ini, AIOSMITHBCoord, AIOSMITHBYCord

FileInstall, D:\OBoT\TeleAlchBanner.png, %A_ScriptDir%/Essentials\AIOSMITHER.png, 1

FileCreateDir, Essentials

Gui, Show , w250 h190, AIO Smither v1.0

Gui,Font,s10 bold c000000, Oswald
Gui, Add, Picture, x20 y-5 w205 h85, Essentials\AIOSMITHER.png
Gui, Color, E2E2E2
Gui,Font,s12 bold c0000FF, Arial
Gui,Font,s8 c000000, Oswald
Gui, Add, Button, x7 y80 w180 h40 gStartPrivateScript, Start Script
Gui, Add, Button, x190 y80 w50 h40 gStopScript, Stop Script

  Gui, Add, GroupBox, x2 y120 w167 h63, Preparation
Gui, Add, Button, x7 y135 w75 h40 gAligncamera, Align Camera
Gui, Add, Button, x87 y135 w75 h40 gResizeBlueStacks, Resize BlueStacks
  Gui, Add, GroupBox, x180 y124 w57 h55,
      Gui, Add, GroupBox, x176 y120 w65 h64,
Gui, Add, Button, x183 y135 w50 h39 gWebInstructions, INFO
return

WebInstructions:
Run, https://orangedev.netscript-explanations-tutorials/private-script-bluestacks-dartsmither/
Return

;*****
StartPrivateScript:
Gui, 2: Color, E2E2E2
Gui, 2: Font,s8 c000000, Oswald
Gui, 2: Add, Radio, x22 y49 w110 h20 vDartsm, Dart tip
Gui, 2: Add, Radio, x22 y69 w110 h20 vPsmith, Platebody
Gui, 2: Add, Radio, x22 y29 w70 h20 v2hsmith, 2H Sword
Gui, 2: Add, Button, x12 y92 w110 h30 Default gStartItemselect, START
Gui, 2: Add, Text, x92 y19 w40 h0 , Text
Gui, 2: Add, GroupBox, x12 y9 w130 h82 , Select item
Gui, 2: Add, Button, x122 y97 w20 h20 gRequestitem, ?
Gui, 2: Add, Text, x112 y159 w60 h-120 , Request item
Gui, 2: Show, x127 y87 h134 w159, Select item
Return

Requestitem:
MsgBox, 4096, ITEM REQUEST, To request an item please message NotOrange#1595 via discord.
Return

GuiClose:
GuiEscape:
ExitApp
return

StartItemselect:
Gui, Submit
if (Dartsm = 1) & (Psmith = 0) & (2hsmith = 0)
Goto, dartsmith
else if (Dartsm = 0) & (Psmith = 1) & (2hsmith = 0)
Goto, AIOPLATE
else if (Dartsm = 0) & (Psmith = 0) & (2hsmith = 1)
Goto, 2hsmither
else if (Dartsm = 0) & (Psmith = 0) & (2hsmith = 0)
GoTo, plsselect
Return

plsselect:
MsgBox, 4096, ERROR!, Please select an Item to smith from the item selection menu before clicking the START button.
ExitApp
return
;****************************************DESIGNATE ANVIL COORDINATE*********************************************
; ensure you are standing at the bank booth whilst designating this COORDINATE
+F3::  ;  Designate Anvil Coord With Shift F3
	IfWinExist, BlueStacks
	WinActivate, BlueStacks
MouseGetPos, ADesPosX, ADesPosY
IniWrite, %ADesPosX%, Essentials\Coordinates.ini, AIOSMITHACoord, AIOSMITHAXCord
IniWrite, %ADesPosY%, Essentials\Coordinates.ini, AIOSMITHACoord, AIOSMITHAYCord
soundbeep
return

;****************************************DESIGNATE BANK COORDINATE************************************************
; ensure you are standing at the anvil location whilst designating this COORDINATE
+F4::  ;  Designate Bank Coord With Shift F4
	IfWinExist, BlueStacks
	WinActivate, BlueStacks
MouseGetPos, BDesPosX, BDesPosY
IniWrite, %BDesPosX%, Essentials\Coordinates.ini, AIOSMITHBCoord, AIOSMITHBXCord
IniWrite, %BDesPosY%, Essentials\Coordinates.ini, AIOSMITHBCoord, AIOSMITHBYCord
soundbeep
return

;***********************************************SET CAMERA VIEW*******************************************
aligncamera:
Shift & F2::
Controlclick, x734 y70, BlueStacks,,,, NA ; Click compass
Sleep, 30
SetControlDelay -1
ControlClick, x736 y72, BlueStacks,,,, NA; clickcompass
sleep 100
            Controlclick, x482 y289, BlueStacks,, WheelUp, 1, NA ; wheel up

ControlClick, x725 y112, BlueStacks,,,, NA ; FOR SOME REASON THIS IS NECESSARY TO DO BIRDSEYE
return

;***********************************************RESIZE BLUESTACKS*******************************************
resizebluestacks:
Shift & F1::
WinExist("BlueStacks")
WinGetPos, X, Y, Width, Height, BlueStacks
WinGetPos,,, sizeX, sizeY
        WinMove, BlueStacks,, %X%, %Y%, 800, 600
;        WinMove, BlueStacks,, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2), 800, 600
msgbox, 4096, BlueStacks, The BlueStacks window has been resized to the correct size. You can now move the BlueStacks window. (Recommended: Out of the way, but still visible)
return

;***********************************************STOP SCRIPT************************************************
StopScript:
F12::reload
Gui Destroy
ExitApp
return


;***********************************************PLATEBODY SMITHER******************************************
AIOPLATE:
CoordMode, ToolTip, screen
CoordMode, Mouse, screen
CoordMode, Pixel, screen
	IfWinExist, BlueStacks
    WinGetPos, XStart, YStart, Width, Height, BlueStacks

    Loop 3000
                    {
                        PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
                        if Errorlevel = 1
                        {
                            Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
                            sleep, 1500
                          }
                        else
                            Goto, ham1234177


                ham1234177:
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x052E49, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x525259, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x05304B, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x05314D, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          Goto, initialstartpbs
                          else
                          Goto, error

                    }

            error:
            MsgBox,4096,ERROR!, Hammer is not found! Please follow the instructions and try again.
            reload

;***********************************************CLICKING RANDOMISATION*********************************************
    Random, minrand, 285, 350
    Random, smallrand, 285, 325
    Random, midrand, 300, 500
    Random, bigrand, 500, 1000
    Random, checkrand, 1, 3
    SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
    Random, randchoice, 1, 8
    Sleep, SleepTimes[randchoice]

;**********************************************INITIAL START OF SCRIPT*********************************************

initialstartpbs:
Controlclick, x473 y296, BlueStacks,,,, NA ; Open bank - initial START
sleep 300
Loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep 100
else
  GoTo, depositinventory177
}
Goto, initialstartpbs

depositinventory177:
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 250, 500
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

  Controlclick, x569 y507, BlueStacks,,,, NA ; Deposit INVENTORY
sleep 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


  Controlclick, x212 y293, BlueStacks,,,, NA ; Withdraw bars
sleep, 700
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


  Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 750
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


    Controlclick, x%ADesPosX% y%ADesPosY%, BlueStacks,,,, NA ; Click anvil

loop 150
{
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1F98FF, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F7, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F6, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
  sleep, 100
else
  GoTo, clickholdplate
}
        GoTo, beginloop
clickholdplate:

Controlclick, x325 y423, BlueStacks,,,, NA ; Click make PLATEBODY

    Loop 118
                                {
                                    PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                    if Errorlevel = 0
                                    {
                                        ControlSend, , {Space}, BlueStacks
                                        sleep 1500
                                        ControlSend, , {Space}, BlueStacks
                                        sleep 1500
                                        Goto, beginloop
                                    }
                                    else
                          PixelSearch, X62, Y62, XStart+723, YStart+179,XStart+748, YStart+182, 0x0B0B0B, 2, Fast ;
                          if Errorlevel = 1
                          PixelSearch, X62, Y62, XStart+723, YStart+179,XStart+748, YStart+182, 0x131313, 2, Fast ;
                          if Errorlevel = 1
                          Goto, beginloop
                          else
                          Goto, runrestoresequence ; if run energy low go to run energy sequence
                          }


;******************************************************BEGIN SCRIPT LOOP**************************************************
beginloop:

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup
                                }
                                else
sleep, 400
Goto, nextcheck831231277
}

nextcheck831231277:

sleep, 3000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup
                                }
                                else
sleep, 400
Goto, nextcheck87878762
}

nextcheck87878762:

sleep, 2500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]




Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup
                                }
                                else
sleep, 400
Goto, nextcheck2123878
}

nextcheck2123878:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup
                                }
                                else

                                sleep, 400
                                Goto, nextcheck2123
                                }

nextcheck2123:
sleep, 3000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


finlvlup:

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup
                                }
                                else

    Controlclick, x%BDesPosX% y%BDesPosY%, BlueStacks,,,, NA ; Click bank
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Goto, check12345
}

check12345:
Loop 150
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep, 100
else
  GoTo, depositinventory
}
Goto, initialstartpbs



depositinventory:
sleep, 350
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]



    Controlclick, x569 y507, BlueStacks,,,, NA ; Deposit INVENTORY
sleep, 750
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


    Controlclick, x212 y293, BlueStacks,,,, NA ; Withdraw bars
sleep, 800
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


    Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 750
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


      Controlclick, x%ADesPosX% y%ADesPosY%, BlueStacks,,,, NA ; Click anvil
sleep, 1000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]



loop 150
{
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1F98FF, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F7, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F6, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
  sleep, 100
else
  GoTo, clickhold
}
  sleep, 300
        GoTo, beginloop

clickhold:

Controlclick, x325 y423, BlueStacks,,,, NA ; Click make-all PLATEBODY

Loop 118
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, beginloop
                                }
                                else
                      PixelSearch, X62, Y62, XStart+723, YStart+179,XStart+748, YStart+182, 0x0B0B0B, 2, Fast ;
                      if Errorlevel = 1
                      PixelSearch, X62, Y62, XStart+723, YStart+179,XStart+748, YStart+182, 0x131313, 2, Fast ;
                      if Errorlevel = 1
                      Goto, beginloop
                      else
                      Goto, runrestoresequence ; if run energy low go to run energy sequence
                      }



;*************************************************LOGOUT SEQUENCE*********************************************************

;logout:
;sleep, 300
;Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
;sleep, 300
;Random, randchoice, 1, 8
;Sleep, SleepTimes[randchoice]
;Controlclick, x877 y501, BlueStacks,,,, NA ; Click logout Tab
;sleep, 1000
;Random, randchoice, 1, 8
;Sleep, SleepTimes[randchoice]
;Controlclick, x757 y481, BlueStacks,,,, NA ; CLICK LOGOUT CHECK
;sleep, 1000
;Random, randchoice, 1, 8
;Sleep, SleepTimes[randchoice]
;MsgBox,4096,ERROR!, The bot could not find any nests! Please follow the instructions and try again! YOU HAVE BEEN LOGGED OUT.
;reload
;return

;*********************************************************RUN ENERGY RESTORE SEQUENCE***************************************************
runrestoresequence:

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup666
                                }
                                else
sleep, 400
Goto, nextcheck8312312666
}

nextcheck8312312666:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup666
                                }
                                else
sleep, 400
Goto, nextcheck87878762666
}

nextcheck87878762666:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]




Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup666
                                }
                                else
sleep, 400
Goto, nextcheck2123878666
}

nextcheck2123878666:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup666
                                }
                                else

                                sleep, 400
                                Goto, nextcheck2123666
                                }

nextcheck2123666:
sleep, 3000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


finlvlup666:

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup666
                                }
                                else

    Controlclick, x%BDesPosX% y%BDesPosY%, BlueStacks,,,, NA ; Click bank
    sleep, 1500
    Random, randchoice, 1, 8
    Sleep, SleepTimes[randchoice]
    Goto, check12345666
    }

    check12345666:

Loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep, 100
else
GoTo, depositinventoryRESTORE
}
Goto, initialstartpbs

depositinventoryRESTORE:

sleep, 300
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]



Controlclick, x569 y507, BlueStacks,,,, NA ; Deposit INVENTORY
sleep, 750
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, staminacheck

;*********************************************4 DOSE STAMINA CHECK****************************************************

staminacheck:
Loop 50
{
PixelSearch, X62, Y62, XStart+250, YStart+290,XStart+269, YStart+303, 0x3F7097, 1, Fast ;
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+250, YStart+290,XStart+269, YStart+303, 0x315876, 2, Fast ;
if Errorlevel = 1
sleep 1
else
Goto, withdraw4S ; if yes withdraw stamina(4)
}
Goto, stam3 ; if not go to stamina (3) check

;*******************************************3 DOSE STAMINA CHECK******************************************************

stam3:
Loop 50
{
PixelSearch, X62, Y62, XStart+299, YStart+281,XStart+317, YStart+302, 0x3B6B91, 1, Fast ;
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+299, YStart+281,XStart+317, YStart+302, 0x3C6D93, 2, Fast ;
if Errorlevel = 1
sleep 1
else
Goto, withdraw3S ; if yes withdraw stamina(3)
}
Goto, stam2 ; if not go to stamina (2) check

;**********************************************2 DOSE STAMINA CHECK*****************************************************

stam2:
Loop 50
{
PixelSearch, X62, Y62, XStart+347, YStart+288,XStart+366, YStart+305, 0x366182, 1, Fast ;
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+347, YStart+288,XStart+366, YStart+305, 0x3C6C92, 2, Fast ;
if Errorlevel = 1
sleep 1
else
Goto, withdraw2S ; if yes withdraw stamina(2)
}
Goto, stam1 ; if not go to stamina (1) check

;***********************************************1 DOSE STAMINA CHECK***************************************************

stam1:
Loop 50
{
PixelSearch, X62, Y62, XStart+392, YStart+289,XStart+416, YStart+307, 0x2E5573, 1, Fast ;
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+392, YStart+289,XStart+416, YStart+307, 0x2E5674, 1, Fast ;
if Errorlevel = 1
sleep 1
else
Goto, withdraw1S ; if yes withdraw stamina(1)
}
Goto, initialstartpbs ; if not go to initial start

;******************************WITHDRAW FAILSAFE STAMINA***********************************

failedstaminawithdraw:
Controlclick, x473 y296, BlueStacks,,,, NA ; Open bank - initial START
sleep 100
Loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep 100
else
  GoTo, depositinventoryRESTORE
}
Goto, failedstaminawithdraw

;***********************************STAMINA (4) WITHDRAW + DRINK SEQUENCE****************************************

withdraw4S:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x260 y295, BlueStacks,,,, D ; Click+hold on stamina potion (4)
SetControlDelay, 100

loop 100
{
PixelSearch, X62, Y62, XStart+211, YStart+335, XStart+334, YStart+350, 0x408DF8, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+211, YStart+335, XStart+334, YStart+350, 0x3981E5, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+211, YStart+335, XStart+334, YStart+350, 0x3475C, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
sleep, 100
else
  GoTo, cw1s
}
  GoTo, withdraw4S

cw1s:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x243 y342, BlueStacks,,,, NA ; click withdraw 1 stamina potion (4)
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
if Errorlevel = 1
{
  sleep, 300
        Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
}
else
  GoTo, potcheck1

potcheck1:
sleep, 400
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 100
{
PixelSearch, X62, Y62, XStart+721, YStart+263,XStart+745, YStart+290, 0x3F7097, 1, Fast ; check inventory for potion
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+721, YStart+263,XStart+745, YStart+290, 0x315876, 2, Fast ; check inventory for potion
if Errorlevel = 1
sleep 100
else
Goto, dsp4 ; if yes drink stamina (4)
}
Goto, failedstaminawithdraw ; if not go to failsafe restart

dsp4:
Controlclick, x734 y281, BlueStacks,,,, NA ; click drink stamina potion
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, initialstartpbs

;***********************************STAMINA (3) WITHDRAW + DRINK SEQUENCE****************************************

withdraw3S:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x309 y295, BlueStacks,,,, D ; Click+hold on stamina potion (3)
SetControlDelay, 100

loop 100
{
PixelSearch, X62, Y62, XStart+260, YStart+334, XStart+381, YStart+350, 0x408DF8, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+260, YStart+334, XStart+381, YStart+350, 0x3981E5, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+260, YStart+334, XStart+381, YStart+350, 0x3475C, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
sleep, 100
else
  GoTo, cw2s
}
  GoTo, withdraw3S

cw2s:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x296 y341, BlueStacks,,,, NA ; click withdraw 1 stamina potion (3)
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
if Errorlevel = 1
{
  sleep, 300
        Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
}
else
  GoTo, potcheck2

potcheck2:
sleep, 400
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 100
{
PixelSearch, X62, Y62, XStart+724, YStart+267,XStart+742, YStart+291, 0x3B6B91, 1, Fast ; check inventory for potion
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+724, YStart+267,XStart+742, YStart+291, 0x3C6D93, 2, Fast ; check inventory for potion
if Errorlevel = 1
sleep 100
else
Goto, dsp3 ; if yes drink stamina (3)
}
Goto, failedstaminawithdraw ; if not go to failsafe restart

dsp3:
Controlclick, x734 y281, BlueStacks,,,, NA ; click drink stamina potion
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, initialstartpbs

;***********************************STAMINA (2) WITHDRAW + DRINK SEQUENCE****************************************

withdraw2S:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x357 y295, BlueStacks,,,, D ; Click+hold on stamina potion (2)
SetControlDelay, 100

loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+336, XStart+429, YStart+348, 0x408DF8, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+336, XStart+429, YStart+348, 0x3981E5, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+336, XStart+429, YStart+348, 0x3475C, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
sleep, 100
else
 GoTo, cw3s
}
  GoTo, withdraw2S

cw3s:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x358 y342, BlueStacks,,,, NA ; click withdraw 1 stamina potion (2)
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
if Errorlevel = 1
{
  sleep, 300
        Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
}
else
  GoTo, potcheck3

potcheck3:
sleep, 400
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 100
{
PixelSearch, X62, Y62, XStart+724, YStart+267,XStart+742, YStart+291, 0x366182, 1, Fast ; check inventory for potion
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+724, YStart+267,XStart+742, YStart+291, 0x3C6D92, 2, Fast ; check inventory for potion
if Errorlevel = 1
sleep 100
else
Goto, dsp2 ; if yes drink stamina (2)
}
Goto, failedstaminawithdraw ; if not go to failsafe restart

dsp2:
Controlclick, x734 y281, BlueStacks,,,, NA ; click drink stamina potion
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, initialstartpbs

;***********************************STAMINA (1) WITHDRAW + DRINK SEQUENCE****************************************

withdraw1S:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x405 y295, BlueStacks,,,, D ; Click+hold on stamina potion (1)
SetControlDelay, 100

loop 100
{
PixelSearch, X62, Y62, XStart+356, YStart+336, XStart+475, YStart+349, 0x408DF8, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+356, YStart+336, XStart+475, YStart+349, 0x3981E5, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+356, YStart+336, XStart+475, YStart+349, 0x3475C, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
sleep, 100
else
 GoTo, cw4s
}
  GoTo, withdraw1S

cw4s:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x392 y342, BlueStacks,,,, NA ; click withdraw 1 stamina potion (1)
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
if Errorlevel = 1
{
  sleep, 300
        Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
}
else
  GoTo, potcheck4

potcheck4:
sleep, 400
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 100
{
PixelSearch, X62, Y62, XStart+726, YStart+274,XStart+746, YStart+291, 0x2E5573, 1, Fast ; check inventory for potion
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+726, YStart+274,XStart+746, YStart+291, 0x2E5674, 1, Fast ; check inventory for potion
if Errorlevel = 1
sleep 100
else
Goto, dsp1 ; if yes drink stamina (2)
}
Goto, failedstaminawithdraw ; if not go to failsafe restart

dsp1:
Controlclick, x734 y281, BlueStacks,,,, NA ; click drink stamina potion
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, initialstartpbs

return


;************************************************DART TIP SMITHER***********************************************
dartsmith:
CoordMode, ToolTip, screen
CoordMode, Mouse, screen
CoordMode, Pixel, screen
	IfWinExist, BlueStacks
    WinGetPos, XStart, YStart, Width, Height, BlueStacks

    Loop 3000
                    {
                        PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
                        if Errorlevel = 1
                        {
                            Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
                            sleep, 1500
                          }
                        else
                            Goto, ham12341


                ham12341:
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x052E49, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x525259, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x05304B, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x05314D, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          Goto, initialstartDS
                          else
                          Goto, errorD

                    }

            errorD:
            MsgBox,4096,ERROR!, Hammer is not found! Please follow the instructions and try again.
            reload

;***********************************************CLICKING RANDOMISATION*********************************************
    Random, minrand, 200, 350
    Random, smallrand, 200, 285
    Random, midrand, 300, 500
    Random, bigrand, 500, 1000
    SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
    Random, randchoice, 1, 8
    Sleep, SleepTimes[randchoice]

;**********************************************INITIAL START OF SCRIPT*********************************************

initialstartDS:
Controlclick, x473 y296, BlueStacks,,,, NA ; Open bank - initial START
sleep 500
Loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep 100
else
  GoTo, depositinventory1
}
Goto, initialstartDS

depositinventory1:
sleep 500
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]
  Controlclick, x569 y507, BlueStacks,,,, NA ; Deposit INVENTORY
sleep 500
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

  Controlclick, x212 y293, BlueStacks,,,, NA ; Withdraw bars
sleep, 700
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

  Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 650
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

    Controlclick, x%ADesPosX% y%ADesPosY%, BlueStacks,,,, NA ; Click anvil

loop 150
{
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1F98FF, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F7, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F6, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
  sleep, 100
else
  GoTo, clickholdDart
}
        GoTo, beginloopD
clickholdDart:

Controlclick, x486 y259, BlueStacks,,,, NA ; Click make darts

GoTo, beginloopD
return

;******************************************************BEGIN SCRIPT LOOP**************************************************
beginloopD:
Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup1212
                                }
                                else
sleep, 400
Goto, nextcheck899998888111222
}

nextcheck899998888111222:

sleep, 10000
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup1212
                                }
                                else
sleep, 400
Goto, nextcheck899998888232323
}

nextcheck899998888232323:

sleep, 10000
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup1212
                                }
                                else
sleep, 400
Goto, nextcheck8999988887777
}

nextcheck8999988887777:

sleep, 10000
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup1212
                                }
                                else
sleep, 400
Goto, nextcheck899998888
}

nextcheck899998888:

sleep, 10000
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup1212
                                }
                                else
sleep, 400
Goto, nextcheck8312312
}

nextcheck8312312:

sleep, 10000
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup1212
                                }
                                else
sleep, 400
Goto, nextcheck8787876277
}

nextcheck8787876277:

sleep, 10000
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]



Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup1212
                                }
                                else
sleep, 400
Goto, nextcheck21238786666
}

nextcheck21238786666:

sleep, 10000
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup1212
                                }
                                else

                                sleep, 400
                                Goto, nextcheck2123232
                                }

nextcheck2123232:

sleep, 8000
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

finlvlup1212:

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup1212
                                }
                                else

    Controlclick, x%BDesPosX% y%BDesPosY%, BlueStacks,,,, NA ; Click bank
sleep, 1500
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]
Goto, check12314
}

check12314:
Loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep 100
else
  GoTo, depositinventory99
}
Goto, beginloopD



depositinventory99:


    Controlclick, x569 y507, BlueStacks,,,, NA ; Deposit INVENTORY
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

    Controlclick, x212 y293, BlueStacks,,,, NA ; Withdraw bars
sleep, 700
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

    Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 650
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

      Controlclick, x%ADesPosX% y%ADesPosY%, BlueStacks,,,, NA ; Click anvil
sleep, 1000
Random, minrand, 200, 350
Random, smallrand, 200, 285
Random, midrand, 300, 500
Random, bigrand, 500, 1000
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


loop 150
{
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1F98FF, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F7, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F6, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
  sleep, 100
else
  GoTo, clickholdD
}
  sleep, 300
        GoTo, beginloopD

clickholdD:
Controlclick, x486 y259, BlueStacks,,,, NA ; Click make darts

GoTo, beginloopD
return

;****************************************************2h SWORD SMITHER*************************************
2hsmither:
CoordMode, ToolTip, screen
CoordMode, Mouse, screen
CoordMode, Pixel, screen
	IfWinExist, BlueStacks
    WinGetPos, XStart, YStart, Width, Height, BlueStacks

    Loop 3000
                    {
                        PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
                        if Errorlevel = 1
                        {
                            Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
                            sleep, 1500
                          }
                        else
                            Goto, ham123412h


                ham123412h:
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x052E49, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x525259, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x05304B, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          PixelSearch, X62, Y62, XStart+683, YStart+262, XStart+697, YStart+285, 0x05314D, 5, Fast ; checking if hammer = present
                          if Errorlevel = 0
                          Goto, initialstart2hs
                          else
                          Goto, error232

                    }

            error232:
            MsgBox,4096,ERROR!, Hammer is not found! Please follow the instructions and try again.
            reload

;***********************************************CLICKING RANDOMISATION*********************************************
    Random, minrand, 285, 350
    Random, smallrand, 285, 325
    Random, midrand, 300, 500
    Random, bigrand, 500, 1000
    Random, checkrand, 1, 3
    SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
    Random, randchoice, 1, 8
    Sleep, SleepTimes[randchoice]

;**********************************************INITIAL START OF SCRIPT*********************************************

initialstart2hs:
Controlclick, x473 y296, BlueStacks,,,, NA ; Open bank - initial START
sleep 300
Loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep 100
else
  GoTo, depositinventory2h2h
}
Goto, initialstart2hs

depositinventory2h2h:

  Controlclick, x569 y507, BlueStacks,,,, NA ; Deposit INVENTORY
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


  Controlclick, x212 y293, BlueStacks,,,, NA ; Withdraw bars
sleep, 700
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


  Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 750
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


    Controlclick, x%ADesPosX% y%ADesPosY%, BlueStacks,,,, NA ; Click anvil

loop 150
{
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1F98FF, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F7, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F6, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
  sleep, 100
else
  GoTo, clickhold2h2h
}
        GoTo, beginloop2h
clickhold2h2h:

Controlclick, x165 y480, BlueStacks,,,, NA ; make 2h SWORD

    Loop 118
                                {
                                    PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                    if Errorlevel = 0
                                    {
                                        ControlSend, , {Space}, BlueStacks
                                        sleep 1500
                                        ControlSend, , {Space}, BlueStacks
                                        sleep 1500
                                        Goto, beginloop2h
                                    }
                                    else
                          PixelSearch, X62, Y62, XStart+723, YStart+179,XStart+748, YStart+182, 0x0B0B0B, 2, Fast ;
                          if Errorlevel = 1
                          PixelSearch, X62, Y62, XStart+723, YStart+179,XStart+748, YStart+182, 0x131313, 2, Fast ;
                          if Errorlevel = 1
                          Goto, beginloop2h
                          else
                          Goto, runrestoresequence2h ; if run energy low go to run energy sequence
                          }


;******************************************************BEGIN SCRIPT LOOP**************************************************
beginloop2h:

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h
                                }
                                else
sleep, 400
Goto, nextcheck8312312h
}

nextcheck8312312h:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h
                                }
                                else
sleep, 400
Goto, nextcheck87878762h
}

nextcheck87878762h:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]
;***
Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h
                                }
                                else
sleep, 400
Goto, nextcheck87878762h6662h12555
}

nextcheck87878762h6662h12555:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]
;***
;*******
Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h
                                }
                                else
sleep, 400
Goto, nextcheck87878762hss
}

nextcheck87878762hss:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]
;*******


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h
                                }
                                else
sleep, 400
Goto, nextcheck21232h8782h
}

nextcheck21232h8782h:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h
                                }
                                else

                                sleep, 400
                                Goto, nextcheck21232h
                                }

nextcheck21232h:
sleep, 3000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


finlvlup2h:

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h
                                }
                                else

    Controlclick, x%BDesPosX% y%BDesPosY%, BlueStacks,,,, NA ; Click bank
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Goto, check123452h
}

check123452h:
Loop 150
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep, 100
else
  GoTo, depositinventory2h
}
Goto, initialstart2hs



depositinventory2h:
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]



    Controlclick, x569 y507, BlueStacks,,,, NA ; Deposit INVENTORY
sleep, 750
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


    Controlclick, x212 y293, BlueStacks,,,, NA ; Withdraw bars
sleep, 800
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


    Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 750
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


      Controlclick, x%ADesPosX% y%ADesPosY%, BlueStacks,,,, NA ; Click anvil
sleep, 1000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]



loop 150
{
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1F98FF, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F7, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+286, YStart+213, XStart+470, YStart+228, 0x1E93F6, 5, Fast ; checking if smithing UI opened
if Errorlevel = 1
  sleep, 100
else
  GoTo, clickhold2h
}
  sleep, 300
        GoTo, beginloop2h

clickhold2h:

Controlclick, x165 y480, BlueStacks,,,, NA ; click make 2h sword

Loop 118
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, beginloop2h
                                }
                                else
                      PixelSearch, X62, Y62, XStart+723, YStart+179,XStart+748, YStart+182, 0x0B0B0B, 2, Fast ;
                      if Errorlevel = 1
                      PixelSearch, X62, Y62, XStart+723, YStart+179,XStart+748, YStart+182, 0x131313, 2, Fast ;
                      if Errorlevel = 1
                      Goto, beginloop2h
                      else
                      Goto, runrestoresequence2h ; if run energy low go to run energy sequence
                      }


;*********************************************************RUN ENERGY RESTORE SEQUENCE***************************************************
runrestoresequence2h:

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h666
                                }
                                else
sleep, 400
Goto, nextcheck8312312h6662h
}

nextcheck8312312h6662h:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h666
                                }
                                else
sleep, 400
Goto, nextcheck87878762h6662h
}

nextcheck87878762h6662h:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

;***
Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h666
                                }
                                else
sleep, 400
Goto, nextcheck87878762h6662h12
}

nextcheck87878762h6662h12:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]
;***

;***
Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h666
                                }
                                else
sleep, 400
Goto, nextcheck87878762h6662h12222
}

nextcheck87878762h6662h12222:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]
;***


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h666
                                }
                                else
sleep, 400
Goto, nextcheck21232h8782h6662h
}

nextcheck21232h8782h6662h:

sleep, 4000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h666
                                }
                                else

                                sleep, 400
                                Goto, nextcheck21232h6662h
                                }

nextcheck21232h6662h:
sleep, 3000
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


finlvlup2h666:

Loop 1000
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    Goto, finlvlup2h666
                                }
                                else

    Controlclick, x%BDesPosX% y%BDesPosY%, BlueStacks,,,, NA ; Click bank
    sleep, 1500
    Random, randchoice, 1, 8
    Sleep, SleepTimes[randchoice]
    Goto, check123452h6662h
    }

    check123452h6662h:

Loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep, 100
else
GoTo, depositinventory2hRESTORE
}
Goto, initialstart2hs

depositinventory2hRESTORE:

sleep, 300
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]



Controlclick, x569 y507, BlueStacks,,,, NA ; Deposit INVENTORY
sleep, 750
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, staminacheck2h

;*********************************************4 DOSE STAMINA CHECK****************************************************

staminacheck2h:
Loop 50
{
PixelSearch, X62, Y62, XStart+250, YStart+290,XStart+269, YStart+303, 0x3F7097, 1, Fast ;
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+250, YStart+290,XStart+269, YStart+303, 0x315876, 2, Fast ;
if Errorlevel = 1
sleep 1
else
Goto, withdraw4S2h ; if yes withdraw stamina(4)
}
Goto, stam32h ; if not go to stamina (3) check

;*******************************************3 DOSE STAMINA CHECK******************************************************

stam32h:
Loop 50
{
PixelSearch, X62, Y62, XStart+299, YStart+281,XStart+317, YStart+302, 0x3B6B91, 1, Fast ;
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+299, YStart+281,XStart+317, YStart+302, 0x3C6D93, 2, Fast ;
if Errorlevel = 1
sleep 1
else
Goto, withdraw3S2h ; if yes withdraw stamina(3)
}
Goto, stam22h ; if not go to stamina (2) check

;**********************************************2 DOSE STAMINA CHECK*****************************************************

stam22h:
Loop 50
{
PixelSearch, X62, Y62, XStart+347, YStart+288,XStart+366, YStart+305, 0x366182, 1, Fast ;
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+347, YStart+288,XStart+366, YStart+305, 0x3C6C92, 2, Fast ;
if Errorlevel = 1
sleep 1
else
Goto, withdraw2S2h ; if yes withdraw stamina(2)
}
Goto, stam12h ; if not go to stamina (1) check

;***********************************************1 DOSE STAMINA CHECK***************************************************

stam12h:
Loop 50
{
PixelSearch, X62, Y62, XStart+392, YStart+289,XStart+416, YStart+307, 0x2E5573, 1, Fast ;
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+392, YStart+289,XStart+416, YStart+307, 0x2E5674, 1, Fast ;
if Errorlevel = 1
sleep 1
else
Goto, withdraw1S2h ; if yes withdraw stamina(1)
}
Goto, initialstart2hs ; if not go to initial start

;******************************WITHDRAW FAILSAFE STAMINA***********************************

failedstaminawithdraw2h:
Controlclick, x473 y296, BlueStacks,,,, NA ; Open bank - initial START
sleep 100
Loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep 100
else
  GoTo, depositinventory2hRESTORE
}
Goto, failedstaminawithdraw2h

;***********************************STAMINA (4) WITHDRAW + DRINK SEQUENCE****************************************

withdraw4S2h:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x260 y295, BlueStacks,,,, D ; Click+hold on stamina potion (4)
SetControlDelay, 100

loop 100
{
PixelSearch, X62, Y62, XStart+211, YStart+335, XStart+334, YStart+350, 0x408DF8, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+211, YStart+335, XStart+334, YStart+350, 0x3981E5, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+211, YStart+335, XStart+334, YStart+350, 0x3475C, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
sleep, 100
else
  GoTo, cw1s2h
}
  GoTo, withdraw4S2h

cw1s2h:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x243 y342, BlueStacks,,,, NA ; click withdraw 1 stamina potion (4)
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
if Errorlevel = 1
{
  sleep, 300
        Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
}
else
  GoTo, potcheck12h

potcheck12h:
sleep, 400
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 100
{
PixelSearch, X62, Y62, XStart+721, YStart+263,XStart+745, YStart+290, 0x3F7097, 1, Fast ; check inventory for potion
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+721, YStart+263,XStart+745, YStart+290, 0x315876, 2, Fast ; check inventory for potion
if Errorlevel = 1
sleep 100
else
Goto, dsp42h ; if yes drink stamina (4)
}
Goto, failedstaminawithdraw2h ; if not go to failsafe restart

dsp42h:
Controlclick, x734 y281, BlueStacks,,,, NA ; click drink stamina potion
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, initialstart2hs

;***********************************STAMINA (3) WITHDRAW + DRINK SEQUENCE****************************************

withdraw3S2h:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x309 y295, BlueStacks,,,, D ; Click+hold on stamina potion (3)
SetControlDelay, 100

loop 100
{
PixelSearch, X62, Y62, XStart+260, YStart+334, XStart+381, YStart+350, 0x408DF8, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+260, YStart+334, XStart+381, YStart+350, 0x3981E5, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+260, YStart+334, XStart+381, YStart+350, 0x3475C, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
sleep, 100
else
  GoTo, cw2s2h
}
  GoTo, withdraw3S2h

cw2s2h:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x296 y341, BlueStacks,,,, NA ; click withdraw 1 stamina potion (3)
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
if Errorlevel = 1
{
  sleep, 300
        Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
}
else
  GoTo, potcheck22h

potcheck22h:
sleep, 400
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 100
{
PixelSearch, X62, Y62, XStart+724, YStart+267,XStart+742, YStart+291, 0x3B6B91, 1, Fast ; check inventory for potion
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+724, YStart+267,XStart+742, YStart+291, 0x3C6D93, 2, Fast ; check inventory for potion
if Errorlevel = 1
sleep 100
else
Goto, dsp32h ; if yes drink stamina (3)
}
Goto, failedstaminawithdraw2h ; if not go to failsafe restart

dsp32h:
Controlclick, x734 y281, BlueStacks,,,, NA ; click drink stamina potion
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, initialstart2hs

;***********************************STAMINA (2) WITHDRAW + DRINK SEQUENCE****************************************

withdraw2S2h:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x357 y295, BlueStacks,,,, D ; Click+hold on stamina potion (2)
SetControlDelay, 100

loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+336, XStart+429, YStart+348, 0x408DF8, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+336, XStart+429, YStart+348, 0x3981E5, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+336, XStart+429, YStart+348, 0x3475C, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
sleep, 100
else
 GoTo, cw3s2h
}
  GoTo, withdraw2S2h

cw3s2h:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x358 y342, BlueStacks,,,, NA ; click withdraw 1 stamina potion (2)
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
if Errorlevel = 1
{
  sleep, 300
        Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
}
else
  GoTo, potcheck32h

potcheck32h:
sleep, 400
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 100
{
PixelSearch, X62, Y62, XStart+724, YStart+267,XStart+742, YStart+291, 0x366182, 1, Fast ; check inventory for potion
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+724, YStart+267,XStart+742, YStart+291, 0x3C6D92, 2, Fast ; check inventory for potion
if Errorlevel = 1
sleep 100
else
Goto, dsp22h ; if yes drink stamina (2)
}
Goto, failedstaminawithdraw2h ; if not go to failsafe restart

dsp22h:
Controlclick, x734 y281, BlueStacks,,,, NA ; click drink stamina potion
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, initialstart2hs

;***********************************STAMINA (1) WITHDRAW + DRINK SEQUENCE****************************************

withdraw1S2h:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x405 y295, BlueStacks,,,, D ; Click+hold on stamina potion (1)
SetControlDelay, 100

loop 100
{
PixelSearch, X62, Y62, XStart+356, YStart+336, XStart+475, YStart+349, 0x408DF8, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+356, YStart+336, XStart+475, YStart+349, 0x3981E5, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+356, YStart+336, XStart+475, YStart+349, 0x3475C, 5, Fast ; checking if quantity UI opened
if Errorlevel = 1
sleep, 100
else
 GoTo, cw4s2h
}
  GoTo, withdraw1S2h

cw4s2h:
sleep, 500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x392 y342, BlueStacks,,,, NA ; click withdraw 1 stamina potion (1)
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK
sleep, 600
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
if Errorlevel = 1
{
  sleep, 300
        Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
}
else
  GoTo, potcheck42h

potcheck42h:
sleep, 400
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 100
{
PixelSearch, X62, Y62, XStart+726, YStart+274,XStart+746, YStart+291, 0x2E5573, 1, Fast ; check inventory for potion
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+726, YStart+274,XStart+746, YStart+291, 0x2E5674, 1, Fast ; check inventory for potion
if Errorlevel = 1
sleep 100
else
Goto, dsp12h ; if yes drink stamina (2)
}
Goto, failedstaminawithdraw2h ; if not go to failsafe restart

dsp12h:
Controlclick, x734 y281, BlueStacks,,,, NA ; click drink stamina potion
sleep, 1500
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]


Goto, initialstart2hs

return

;****************************************************BOLT TIP SMITHER***********************************
