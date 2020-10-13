+F8::   ; Copy Coordinates on curser for bluestacks (PixelSearch Coords)
MouseGetPos, PosX, PosY
PixelGetColor, cBGR , %PosX%, %PosY%
WinGetPos,,, w, h, A
clipboard = x%PosX% y%PosY%
return

+F9::   ; Copy Coordinates on curser for bluestacks (Controlclick Coords)
MouseGetPos, PosX, PosY
PixelGetColor, cBGR , %PosX%, %PosY%
WinGetPos,,, w, h, A
clipboard = XStart+%PosX%, YStart+%PosY%
return



;******************************************************************* PUT THESE LINES AT THE START OF YOUR SCRIPTS*********************************************
;FOR EXAMPLE


CoordMode, ToolTip, screen
CoordMode, Mouse, screen
CoordMode, Pixel, screen
	IfWinExist, BlueStacks
    WinGetPos, XStart, YStart, Width, Height, BlueStacks

;ImageSearch, OrientX, OrientY, 0, 0, A_Screenwidth, A_Screenheight, Orient1.png

		;*****************************************************************PIXELSEARCH EXAMPLE****************************************************************

		PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
		if Errorlevel = 1
		{
				    Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
		Goto, startbanking
		}
		else

		;**********************************************************TIMED COLOUR CHECK*********************************************************************

		Loop 100
{
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
if Errorlevel = 1
sleep 1
else
Goto, bankingphase
}
soundbeep
Goto, returnlabel45623423

;***********************************************LOOP STUFF************************8
loop 200
{
PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
    if Errorlevel = 1
    {
      sleep, 300
      Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
    }
    else
    goto, clicklog
    }
    GOTO, WHAT DO IF ALL 200 LOOPS FAIL?.....MSGBOX?...
