Shift & F2::
Controlclick, x734 y70, BlueStacks,,,, NA ; Click compass
Sleep, 30
SetControlDelay -1
ControlClick, x736 y72, BlueStacks,,,, NA; clickcompass
sleep 100
            Controlclick, x482 y289, BlueStacks,, WheelUp, 1, NA ; wheel up

ControlClick, x725 y112, BlueStacks,,,, NA 
return


resizebluestacks:
Shift & F1::
WinExist("BlueStacks")
WinGetPos, X, Y, Width, Height, BlueStacks
WinGetPos,,, sizeX, sizeY
        WinMove, BlueStacks,, %X%, %Y%, 800, 600
;        WinMove, BlueStacks,, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2), 800, 600
msgbox, 4096, BlueStacks, The BlueStacks window has been resized to the correct size. You can now move the BlueStacks window. (Recommended: Out of the way, but still visible)
return

Numpad1::   ; Copy Coordinates on curser for bluestacks (PixelSearch Coords)
MouseGetPos, PosX, PosY
PixelGetColor, cBGR , %PosX%, %PosY%
WinGetPos,,, w, h, A
clipboard = x%PosX% y%PosY%
return
numpad0::
Send Controlclick, x%PosX% y%PosY%, BlueStacks,,,, NA ;
return

Numpad2::   ; Copy Coordinates on curser for bluestacks (Controlclick Coords)
MouseGetPos, PosX, PosY
PixelGetColor, cBGR , %PosX%, %PosY%
WinGetPos,,, w, h, A
clipboard = XStart+%PosX%, YStart+%PosY%
return

Numpad3::  ;  Copy Colour on curser
MouseGetPos, PosX, PosY
PixelGetColor, cBGR , %PosX%, %PosY%
WinGetPos,,, w, h, A
clipboard = %cBGR%
return

Numpad4::   ; Copy Coordinates on curser for bluestacks PixelClick
MouseGetPos, PosX, PosY
PixelGetColor, cBGR , %PosX%, %PosY%
WinGetPos,,, w, h, A
clipboard = %PosX%, %PosY%
return
