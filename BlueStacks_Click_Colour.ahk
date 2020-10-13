CoordMode, pixel, Client
WinGet, winid ,, A ; Get current Window ID
BlockInput, On
  WinActivate, BlueStacks

PixelSearch, X62, Y62, 665, 259, 841, 513, 0xBFBAB0, 10, Fast ; checking absorption in invent

WinActivate ahk_id %winid% ; Activate Old Window
BlockInput, Off
CoordMode, Pixel, screen


if Errorlevel = 1
Goto, Start887564654456456
Else
    Controlclick, x%X62% y%Y62%, BlueStacks,,,, NA ; click absorp
sleep 1000
Goto, Start887564654456456





CoordMode, pixel, Client
WinGet, winid ,, A ; Get current Window ID
BlockInput, On
  WinActivate, BlueStacks

PixelSearch, X62, Y62, 454, 183, 600, 312, 0x304261, 7, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 454, 183, 600, 312, 0x304261, 7, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 454, 183, 600, 312, 0x304261, 7, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 454, 183, 600, 312, 0x304261, 7, Fast
if Errorlevel = 1
{
WinActivate ahk_id %winid% ; Activate Old Window
BlockInput, Off
CoordMode, Pixel, screen
Msgbox, cant find colour cause u retarded
}
Else

WinActivate ahk_id %winid% ; Activate Old Window
BlockInput, Off
CoordMode, Pixel, screen


    Controlclick, x%X62% y%Y62%, BlueStacks,,,, NA ; click bush thing
sleep 1000
Goto, Return






CoordMode, pixel, Client
WinGet, winid ,, A ; Get current Window ID
BlockInput, On
  WinActivate, BlueStacks

PixelSearch, X62, Y62, 179, 94, 593, 549, 0xFFFF00, 2, Fast ; check for bankchest colour
if Errorlevel = 1
PixelSearch, X62, Y62, 179, 94, 593, 549, 0xE6E708, 2, Fast ; check for bankchest colour
if Errorlevel = 1
{
WinActivate ahk_id %winid% ; Activate Old Window
BlockInput, Off
CoordMode, Pixel, screen
Msgbox, cant find colour cause u retarded
}
Else

WinActivate ahk_id %winid% ; Activate Old Window
BlockInput, Off
CoordMode, Pixel, screen


    Controlclick, x%X62% y%Y62%, BlueStacks,,,, NA ; click bush thing
