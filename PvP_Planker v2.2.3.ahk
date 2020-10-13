
FileCreateDir, Essentials

Gui, Show , w263 h200, PvP Planker v2.2.3

Gui,Font,s10 bold c000000, Oswald
Gui, Add, Picture, x7 y-2 w250 h80, Essentials\planker.png
Gui, Color, E2E2E2
Gui,Font,s12 bold c0000FF, Arial
Gui,Font,s8 c000000, Oswald
Gui, Add, Button, x180 y73 w20 h20 gWhatisblockinput, ?
Gui, Add, Checkbox, x70 y73 w110 h20 vIsBlock, Block user input
Gui, Add, Button, x17 y93 w180 h40 Default gStartPrivateScript, Start Script
Gui, Add, Button, x200 y93 w50 h40 gStopScript, Stop Script

  Gui, Add, GroupBox, x12 y133 w167 h63, Preparation
Gui, Add, Button, x17 y148 w75 h40 gAligncamera, Align Camera
Gui, Add, Button, x97 y148 w75 h40 gResizeBlueStacks, Resize BlueStacks
  Gui, Add, GroupBox, x190 y137 w57 h55,
      Gui, Add, GroupBox, x186 y132 w65 h64,
Gui, Add, Button, x193 y148 w50 h39 gWebInstructions, INFO
return

WebInstructions:
Run, orangedev.netscript-explanations-tutorials/bluestacks-pvp-planker/
Return


GuiClose:
GuiEscape:
ExitApp
return

Whatisblockinput:
MsgBox, 4096, What is block user input?, Block user input will block all mouse actions that usually interrupt a bot. This is best utilized when using a Virtual Machine.
return

;***********************************************SET CAMERA VIEW*******************************************
aligncamera:
Shift & F2::
BlockInput, on
Instruction := "BlueStacks Camera angle is being configured! Please wait :)"
Title := "Configuring"
MainIcon := 1401
Flags := 0xC00
Buttons := 0x1
TDCallback := RegisterCallback("TDCallback", "Fast")
CBData := {}
CBData.AlwaysOnTop := True
CBData.Marquee := True
CBData.Timeout := 3000 ; ms

; TASKDIALOGCONFIG structure
x64 := A_PtrSize == 8
NumPut(VarSetCapacity(TDC, x64 ? 160 : 96, 0), TDC, 0, "UInt") ; cbSize
NumPut(Flags, TDC, x64 ? 20 : 12, "Int") ; dwFlags
NumPut(Buttons, TDC, x64 ? 24 : 16, "Int") ; dwCommonButtons
NumPut(&Title, TDC, x64 ? 28 : 20, "Ptr") ; pszWindowTitle
NumPut(MainIcon, TDC, x64 ? 36 : 24, "Ptr") ; pszMainIcon
NumPut(&Instruction, TDC, x64 ? 44 : 28, "Ptr") ; pszMainInstruction
NumPut(TDCallback, TDC, x64 ? 140 : 84, "Ptr") ; pfCallback
NumPut(&CBData, TDC, x64 ? 148 : 88, "Ptr") ; lpCallbackData

TDCallback(hWnd, Notification, wParam, lParam, RefData) {
    Local CBData := Object(RefData)

    If (Notification == 4 && wParam > CBData.Timeout) {
        ; TDM_CLICK_BUTTON := 0x466, IDCANCEL := 2
        PostMessage 0x466, 2, 0,, ahk_id %hWnd%
    }

    If (Notification == 0 && CBData.AlwaysOnTop) {
        DHW := A_DetectHiddenWindows
        DetectHiddenWindows On
        WinSet AlwaysOnTop, On, ahk_id %hWnd%
        DetectHiddenWindows %DHW%
    }

    If (Notification == 0 && CBData.Marquee) {
        ; TDM_SET_PROGRESS_BAR_MARQUEE
        DllCall("PostMessage", "Ptr", hWnd, "UInt", 0x46B, "UInt", 1, "UInt", 50)
    }
}

DllCall("Comctl32.dll\TaskDialogIndirect", "Ptr", &TDC
    , "Int*", Button := 0
    , "Int*", Radio := 0
    , "Int*", Checked := 0)

DllCall("Kernel32.dll\GlobalFree", "Ptr", TDCallback)

If (Button == 1) {
    ; OK

} Else If (Button == 2) {
    ; Timeout

}



CoordMode, ToolTip, screen
CoordMode, Mouse, screen
CoordMode, Pixel, screen
	IfWinExist, BlueStacks
    WinActivate, BlueStacks
    CoordMode, Mouse, Relative
    sendmode, input

SetControlDelay -1
ControlClick, x736 y72, BlueStacks,,,, NA; clickcompass
sleep 100
		    Controlclick, x482 y289, BlueStacks,, WheelUp, 1, NA ; wheel up

ControlClick, x725 y112, BlueStacks,,,, NA ; FOR SOME REASON THIS IS NECESSARY TO DO BIRDSEYE
sleep, 1000
MouseMove, 765, 234,,
SetDefaultMouseSpeed, 50
SendEvent, Click, down
sleep, 300
SendEvent {Click 765, 234, down}{click 199, 234, up}
BlockInput, off

Text := "Your camera angle has been set!"

Result := MsgBoxEx(Text, "Ready!", "OK", [229, "imageres.dll"], "", "AlwaysOnTop", 0, 4, "s9 bold c0x000000", "System", "0xE8E8E8")

If (Result == "OK") {

} Else If (Result == "Cancel") {

} Else If (Result == "TIMEOUT") {

}

MsgBoxEx(Text, Title := "", Buttons := "", Icon := "", ByRef CheckText := "", Styles := "", Owner := "", Timeout := "", FontOptions := "", FontName := "", BGColor := "", Callback := "") {
    Static hWnd, y2, p, px, pw, c, cw, cy, ch, f, o, gL, hBtn, lb, DHW, ww, Off, k, v, RetVal
    Static Sound := {2: "*48", 4: "*16", 5: "*64"}

    Gui New, hWndhWnd LabelMsgBoxEx -0xA0000
    Gui % (Owner) ? "+Owner" . Owner : ""
    Gui Font
    Gui Font, % (FontOptions) ? FontOptions : "s9", % (FontName) ? FontName : "Segoe UI"
    Gui Color, % (BGColor) ? BGColor : "White"
    Gui Margin, 10, 12

    If (IsObject(Icon)) {
        Gui Add, Picture, % "x20 y24 w32 h32 Icon" . Icon[1], % (Icon[2] != "") ? Icon[2] : "shell32.dll"
    } Else If (Icon + 0) {
        Gui Add, Picture, x20 y24 Icon%Icon% w32 h32, user32.dll
        SoundPlay % Sound[Icon]
    }

    Gui Add, Link, % "x" . (Icon ? 65 : 20) . " y" . (InStr(Text, "`n") ? 24 : 32) . " vc", %Text%
    GuicontrolGet c, Pos
    GuiControl Move, c, % "w" . (cw + 30)
    y2 := (cy + ch < 52) ? 90 : cy + ch + 34

    Gui Add, Text, vf -Background ; Footer

    Gui Font
    Gui Font, s9, Segoe UI
    px := 42
    If (CheckText != "") {
        CheckText := StrReplace(CheckText, "*",, ErrorLevel)
        Gui Add, CheckBox, vCheckText x12 y%y2% h26 -Wrap -Background AltSubmit Checked%ErrorLevel%, %CheckText%
        GuicontrolGet p, Pos, CheckText
        px := px + pw + 10
    }

    o := {}
    Loop Parse, Buttons, |, *
    {
        gL := (Callback != "" && InStr(A_LoopField, "...")) ? Callback : "MsgBoxExBUTTON"
        Gui Add, Button, hWndhBtn g%gL% x%px% w90 y%y2% h26 -Wrap, %A_Loopfield%
        lb := hBtn
        o[hBtn] := px
        px += 98
    }
    GuiControl +Default, % (RegExMatch(Buttons, "([^\*\|]*)\*", Match)) ? Match1 : StrSplit(Buttons, "|")[1]

    Gui Show, Autosize Center Hide, %Title%
    DHW := A_DetectHiddenWindows
    DetectHiddenWindows On
    WinGetPos,,, ww,, ahk_id %hWnd%
    GuiControlGet p, Pos, %lb% ; Last button
    Off := ww - (((px + pw + 14) * A_ScreenDPI) // 96)
    For k, v in o {
        GuiControl Move, %k%, % "x" . (v + Off)
    }
    Guicontrol MoveDraw, f, % "x-1 y" . (y2 - 10) . " w" . ww . " h" . 48

    Gui Show
    Gui +SysMenu %Styles%
    DetectHiddenWindows %DHW%

    If (Timeout) {
        SetTimer MsgBoxExTIMEOUT, % Round(Timeout) * 1000
    }

    If (Owner) {
        WinSet Disable,, ahk_id %Owner%
    }

    GuiControl Focus, f
    Gui Font
    WinWaitClose ahk_id %hWnd%
    Return RetVal

    MsgBoxExESCAPE:
    MsgBoxExCLOSE:
    MsgBoxExTIMEOUT:
    MsgBoxExBUTTON:
        SetTimer MsgBoxExTIMEOUT, Delete

        If (A_ThisLabel == "MsgBoxExBUTTON") {
            RetVal := StrReplace(A_GuiControl, "&")
        } Else {
            RetVal := (A_ThisLabel == "MsgBoxExTIMEOUT") ? "Timeout" : "Cancel"
        }

        If (Owner) {
            WinSet Enable,, ahk_id %Owner%
        }

        Gui Submit
        Gui %hWnd%: Destroy
    Return
}


return


;***********************************************RESIZE BLUESTACKS*******************************************
resizebluestacks:
Shift & F1::
WinExist("BlueStacks")
WinGetPos, X, Y, Width, Height, BlueStacks
WinGetPos,,, sizeX, sizeY
	    WinMove, BlueStacks,, %X%, %Y%, 800, 600
;	    WinMove, BlueStacks,, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2), 800, 600
msgbox, 4096, BlueStacks, The BlueStacks window has been resized to the correct size. You can now move the BlueStacks window. (Recommended: Out of the way, but still visible)
return


;***********************************************STOP SCRIPT************************************************
StopScript:
F12::reload
Gui Destroy
ExitApp
return

msgboxxxx:
MsgBox, 4096, Private chat!, Your PRIVATE CHAT is not set to OFF! Please set your PRIVATE CHAT to OFF and try again!
reload
return

;***********************************************SCRIPT START********************************************
StartPrivateScript:
Gui, Submit
if (IsBlock = 1)
GoTo, start889899
if IsBlock = 0
GoTo, start8898
Return

start889899:
BlockInput, MouseMove
MsgBox, 4096, USER INTERACTION BLOCKED!, User interaction has been blocked! Please use F12 to stop the script., 5

goto, start8898
start8898:

CoordMode, ToolTip, screen
CoordMode, Mouse, screen
CoordMode, Pixel, screen
	IfWinExist, BlueStacks
    WinGetPos, XStart, YStart, Width, Height, BlueStacks

PixelSearch, X62, Y62, XStart+248, YStart+60, XStart+304, YStart+76, 0x081566, 10, Fast ; checking if private off
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+248, YStart+60, XStart+304, YStart+76, 0x0A0B89, 10, Fast ; checking if private off
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+248, YStart+60, XStart+304, YStart+76, 0x0A0CCD, 10, Fast ; checking if private off
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+248, YStart+60, XStart+304, YStart+76, 0x0506D2, 10, Fast ; checking if private off
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+248, YStart+60, XStart+304, YStart+76, 0x16199F, 10, Fast ; checking if private off
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+248, YStart+60, XStart+304, YStart+76, 0x15179D, 10, Fast ; checking if private off
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+248, YStart+60, XStart+304, YStart+76, 0x0304EF, 10, Fast ; checking if private off
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+248, YStart+60, XStart+304, YStart+76, 0x0000EC, 10, Fast ; checking if private off
if Errorlevel = 1
{
  Goto, msgboxxxx
  }
else
    GoTo, continuestart

Shift & F8::
continuestart:

Sleep, 500
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x878 y349, BlueStacks,,,, NA ; click stats tab
sleep, 550
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x878 y463, BlueStacks,,,, NA ; click settings
sleep, 550
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x771 y323, BlueStacks,,,, NA ; click height change
sleep, 550
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x820 y358, BlueStacks,,,, NA ; click brightness

sleep, 550
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

;******************BEGIN SCRIPT LOOP*******************
beginloop:
CoordMode, ToolTip, screen
CoordMode, Mouse, screen
CoordMode, Pixel, screen
	IfWinExist, BlueStacks
    WinGetPos, XStart, YStart, Width, Height, BlueStacks

    PixelSearch, X62, Y62, XStart+861, YStart+249, XStart+895, YStart+286, 0x1D2671, 5, Fast ; checking if backpack is open
    if Errorlevel = 1
    {
        Controlclick, x879 y266, BlueStacks,,,, NA ; open backpack
        sleep, 500
      }
    else
        Goto, clicklog

clicklog:
loop 25
{
PixelSearch, X62, Y62, XStart+722, YStart+102, XStart+727, YStart+105, 0x131313, 4, Fast ; checking if health dropped
if Errorlevel = 1
{}
else
  GoTo, teleportasap
}


clicklogactual:



loop 25
{
PixelSearch, X62, Y62, XStart+722, YStart+102, XStart+727, YStart+105, 0x131313, 4, Fast ; checking if health dropped
if Errorlevel = 1
{}
else
  GoTo, teleportasap
}

checkinvisopen:
  PixelSearch, X62, Y62, XStart+859, YStart+248, XStart+891, YStart+285, 0x1D2773, 5, Fast ; checking for open inventory
  if Errorlevel = 1
  PixelSearch, X62, Y62, XStart+859, YStart+248, XStart+891, YStart+285, 0x1A236A, 5, Fast ; checking for open inventory
  if Errorlevel = 1
  {
		Controlclick, x875 y268, BlueStacks,,,, NA ; open inv
    sleep 1500
    Goto, checkinvisopen
  }
  else

Controlclick, x692 y496, BlueStacks,,,, NA ; click log

sleep, 300

    chestfind:
    CoordMode, pixel, Client
    WinGet, winid ,, A ; Get current Window ID
    BlockInput, On
      WinActivate, BlueStacks

      PixelSearch, X62, Y62, 226, 134, 641, 465, 0x303E50, 0, Fast
  		if Errorlevel = 1
      PixelSearch, X62, Y62, 226, 134, 641, 465, 0x2E3B4C, 0, Fast
      if Errorlevel = 1
      PixelSearch, X62, Y62, 226, 134, 641, 465, 0x334255, 0, Fast
      if Errorlevel = 1
      PixelSearch, X62, Y62, 226, 134, 641, 465, 0x2E3B4B, 0, Fast
      if Errorlevel = 1
    PixelSearch, X62, Y62, 226, 134, 641, 465, 0x2E425D, 0, Fast
    if Errorlevel = 1
    PixelSearch, X62, Y62, 226, 134, 641, 465, 0x25364C, 0, Fast
    if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x313F50, 0, Fast
    if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x324153, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x2E3B4C, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x37475C, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x38495D, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x334155, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x354458, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x2A3645, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x202E41, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x202F43, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x24354A, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x1F2C3F, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x283442, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x334154, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x394A5F, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x303E50, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x2F3C4D, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x303F50, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x37465B, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x2E3B4C, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x293545, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 226, 134, 641, 465, 0x2C3949, 0, Fast
		if Errorlevel = 1
    PixelSearch, X62, Y62, 226, 134, 641, 465, 0x303E50, 0, Fast
    if Errorlevel = 1
    PixelSearch, X62, Y62, 226, 134, 641, 465, 0x324153, 0, Fast
    if Errorlevel = 1
    PixelSearch, X62, Y62, 226, 134, 641, 465, 0x354458, 0, Fast
    if Errorlevel = 1
    PixelSearch, X62, Y62, 226, 134, 641, 465, 0x354457, 0, Fast
    if Errorlevel = 1
    {
    WinActivate ahk_id %winid% ; Activate Old Window
    BlockInput, Off
    CoordMode, Pixel, screen
    Goto, chestfindsecondattempt
    }
    Else
    WinActivate ahk_id %winid% ; Activate Old Window
    BlockInput, Off
    CoordMode, Pixel, screen
		Goto, clickbankchest




chestfindsecondattempt:
loop 25
{
PixelSearch, X62, Y62, XStart+722, YStart+102, XStart+727, YStart+105, 0x131313, 4, Fast ; checking if health dropped
if Errorlevel = 1
{}
else
  GoTo, teleportasap
}


  CoordMode, pixel, Client
  WinGet, winid ,, A ; Get current Window ID
  BlockInput, On
  	WinActivate, BlueStacks

sleep 300
    PixelSearch, X62, Y62, 271, 224, 578, 444, 0x2E425D, 0, Fast
    if Errorlevel = 1
    PixelSearch, X62, Y62, 271, 224, 578, 444, 0x25364C, 0, Fast
    if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x313F50, 0, Fast
    if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x324153, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x2E3B4C, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x37475C, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x38495D, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x334155, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x354458, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x2A3645, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x202E41, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x202F43, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x24354A, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x1F2C3F, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x283442, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x334154, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x394A5F, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x303E50, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x2F3C4D, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x303F50, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x37465B, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x2E3B4C, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x293545, 0, Fast
		if Errorlevel = 1
		PixelSearch, X62, Y62, 271, 224, 578, 444, 0x2C3949, 0, Fast
		if Errorlevel = 1
    {
    WinActivate ahk_id %winid% ; Activate Old Window
    BlockInput, Off
    CoordMode, Pixel, screen
		sleep 200
		Controlclick, x692 y496, BlueStacks,,,, NA ; click log
			sleep 200
    Goto, teleporttocamagain
    }
    Else
    WinActivate ahk_id %winid% ; Activate Old Window
    BlockInput, Off
    CoordMode, Pixel, screen
		Goto, clickbankchest

clickbankchest:
        Controlclick, x%X62% y%Y62%, BlueStacks,,,, D ; click bank chest
        SetControlDelay, -1



        loop 10
        {
        PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
        if Errorlevel = 1
        PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
        if Errorlevel = 1
        {}
        else
          GoTo, exitbank
        }

        sleep, 500

        chestuifind:
                CoordMode, pixel, Client
                WinGet, winid ,, A ; Get current Window ID
                BlockInput, On
                  WinActivate, BlueStacks

                  Random, minrand, 75, 115
                  Random, smallrand, 85, 165
                  Random, midrand, 150, 255
                  Random, bigrand, 245, 355
                  SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
                  Random, randchoice, 1, 8
                  Sleep, SleepTimes[randchoice]


                PixelSearch, X62, Y62, 172, 48, 766, 550, 0xFFFF00, 2, Fast ; check for bankchest colour
                if Errorlevel = 1
                PixelSearch, X62, Y62, 172, 48, 766, 550, 0xE6E708, 2, Fast ; check for bankchest colour
                if Errorlevel = 1
                PixelSearch, X62, Y62, 172, 48, 766, 550, 0xD5C00A, 2, Fast ; check for bankchest colour
                if Errorlevel = 1
                PixelSearch, X62, Y62, 172, 48, 766, 550, 0x99870D, 2, Fast ; check for bankchest colour
                if Errorlevel = 1
                PixelSearch, X62, Y62, 172, 48, 766, 550, 0xDECA14, 2, Fast ; check for bankchest colour
                if Errorlevel = 1

                {
                WinActivate ahk_id %winid% ; Activate Old Window
                BlockInput, Off
                CoordMode, Pixel, screen
                                    Controlclick, x722 y112, BlueStacks,,,, NA ; off-click right click menu
                                    sleep 250
                                    Controlclick, x722 y112, BlueStacks,,,, NA ; off-click use item
                Goto, clicklogactual
                }
                Else

                WinActivate ahk_id %winid% ; Activate Old Window
                BlockInput, Off
                CoordMode, Pixel, screen


                    Controlclick, x%X62% y%Y62%, BlueStacks,,,, NA ; click bank chest use UI


        loop 8
        {
        PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1F98FF, 10, Fast ; checking if bank open
        if Errorlevel = 1
        PixelSearch, X62, Y62, XStart+307, YStart+207, XStart+456, YStart+227, 0x1C8AE8, 10, Fast ; checking if bank open
        if Errorlevel = 1
        {}
        else
          GoTo, exitbank
        }

        loop 5
        {
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x00FF00, 2, Fast ; checking if bank click fail
          if Errorlevel = 1
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x02ADFA, 2, Fast ; checking if bank click fail
          if Errorlevel = 1
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x02ADFA, 2, Fast ; checking if bank click fail
          if Errorlevel = 1
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x0000E5, 2, Fast ; checking if bank click fail
          if Errorlevel = 1
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x0202FA, 2, Fast ; checking if bank click fail
          if Errorlevel = 1
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x06F308, 2, Fast ; checking if bank click fail
          if Errorlevel = 1
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x00FD00, 2, Fast ; checking if bank click fail
          if Errorlevel = 1
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x00F4F4, 2, Fast ; checking if bank click fail
          if Errorlevel = 1
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x039FE5, 2, Fast ; checking if bank click fail
          if Errorlevel = 1
          PixelSearch, X62, Y62, XStart+206, YStart+92, XStart+557, YStart+498, 0x04F6BB, 2, Fast ; checking if bank click fail22
          if Errorlevel = 1
        {}
        else
        {
          sleep, 250
          Controlclick, x724 y114, BlueStacks,,,, NA
          sleep, 100
          Controlclick, x724 y114, BlueStacks,,,, NA
          goto, clicklogactual
        }
        }

sleep, 50
        Loop 50
        {
					PixelSearch, X62, Y62, XStart+259, YStart+102, XStart+291, YStart+121, 0x21282C, 15, Fast ; checking if interface open
					if Errorlevel = 1
					PixelSearch, X62, Y62, XStart+259, YStart+102, XStart+291, YStart+121, 0x4B5B63, 15, Fast ; checking if interface open
					if Errorlevel = 1
					PixelSearch, X62, Y62, XStart+259, YStart+102, XStart+291, YStart+121, 0x47565E, 15, Fast ; checking if interface open
					if Errorlevel = 1
					PixelSearch, X62, Y62, XStart+259, YStart+102, XStart+291, YStart+121, 0x3C4B53, 15, Fast ; checking if interface open
					if Errorlevel = 1
        sleep 100
        else
        Goto, doublecheck
        }
        soundbeep
        Goto, clicklog

doublecheck:
sleep, 50
				Loop 50
				{
					PixelSearch, X62, Y62, XStart+89, YStart+71, XStart+104, YStart+84, 0x345838, 15, Fast ; checking if interface open
					if Errorlevel = 1
					PixelSearch, X62, Y62, XStart+89, YStart+71, XStart+104, YStart+84, 0x28513F, 15, Fast ; checking if interface open
					if Errorlevel = 1
					PixelSearch, X62, Y62, XStart+89, YStart+71, XStart+104, YStart+84, 0x195158, 15, Fast ; checking if interface open
					if Errorlevel = 1
				sleep 100
				else
				Goto, tripplecheck
				}
				soundbeep
				Goto, clicklog

tripplecheck:
sleep, 50
				Loop 50
				{
					PixelSearch, X62, Y62, XStart+307, YStart+70, XStart+356, YStart+89, 0x283294, 15, Fast ; checking if interface open
					if Errorlevel = 1
					PixelSearch, X62, Y62, XStart+307, YStart+70, XStart+356, YStart+89, 0x2C3796, 15, Fast ; checking if interface open
					if Errorlevel = 1
					PixelSearch, X62, Y62, XStart+307, YStart+70, XStart+356, YStart+89, 0x262F93, 15, Fast ; checking if interface open
					if Errorlevel = 1
				sleep 100
				else
				Goto, checkspellbook
				}
				soundbeep
				Goto, clicklog





checkspellbook:
sleep, 500
Random, minrand, 10, 20
Random, smallrand, 15, 25
Random, midrand, 15, 30
Random, bigrand, 25, 35
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

				Controlclick, x274 y114, BlueStacks,,,, NA ; unbank note

Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Loop 3000
                {
                  PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+707, YStart+511, 0x96BECE, 15, Fast ; checking if log available
                  if Errorlevel = 1
                  PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+707, YStart+511, 0x87ACBA, 15, Fast ; checking if log available
                  if Errorlevel = 1
                  PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+707, YStart+511, 0x80A4B1, 15, Fast ; checking if log available
                  if Errorlevel = 1
                  PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+707, YStart+511, 0x9EC3D2, 15, Fast ; checking if log available
                  if Errorlevel = 1
                  PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+707, YStart+511, 0x93B8C9, 15, Fast ; checking if log available
                  if Errorlevel = 1
                  PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+707, YStart+511, 0x82AAB4, 15, Fast ; checking if log available
                  if Errorlevel = 1
                  PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+707, YStart+511, 0x90B3C5, 15, Fast ; checking if log available
                  if Errorlevel = 1
                    {
                      Goto, logoutlogsequence
                      }
                    else
                        GoTo, runeavailalala

runeavailalala:
                        PixelSearch, X62, Y62, XStart+661, YStart+253, XStart+855, YStart+520, 0x9797A0, 10, Fast ; checking if runes are available
                        if Errorlevel = 1
                        PixelSearch, X62, Y62, XStart+661, YStart+253, XStart+855, YStart+520, 0xE53128, 10, Fast ; checking if runes are available
                        if Errorlevel = 1
                        PixelSearch, X62, Y62, XStart+661, YStart+253, XStart+855, YStart+520, 0xA8A9B3, 10, Fast ; checking if runes are available
                        if Errorlevel = 1
                        PixelSearch, X62, Y62, XStart+661, YStart+253, XStart+855, YStart+520, 0xE6E6E9, 10, Fast ; checking if runes are available
                        if Errorlevel = 1
                        PixelSearch, X62, Y62, XStart+661, YStart+253, XStart+855, YStart+520, 0xA1A1AB, 10, Fast ; checking if runes are available
                        if Errorlevel = 1
                        PixelSearch, X62, Y62, XStart+661, YStart+253, XStart+855, YStart+520, 0x175C7F, 10, Fast ; checking if runes are available
                        if Errorlevel = 1
                        PixelSearch, X62, Y62, XStart+661, YStart+253, XStart+855, YStart+520, 0x434E6B, 10, Fast ; checking for rune pouch
                        if Errorlevel = 1
                        PixelSearch, X62, Y62, XStart+661, YStart+253, XStart+855, YStart+520, 0x343E62, 10, Fast ; checking for rune pouch
                        if Errorlevel = 1
                        {
                          Goto, logoutrunesequence
                          }
                        else
                            GoTo, coinavail

            coinavail:
            PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+863, YStart+524, 0x28BCDE, 15, Fast ; checking for coins
            if Errorlevel = 0
            PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+863, YStart+524, 0x28BDE0, 15, Fast ; checking for coins
            if Errorlevel = 0
            PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+863, YStart+524, 0x28C5EA, 15, Fast ; checking for coins
            if Errorlevel = 0
            PixelSearch, X62, Y62, XStart+643, YStart+233, XStart+863, YStart+524, 0x28BDE0, 15, Fast ; checking for coins
            if Errorlevel = 0

                      GoTo, finishinvcheck
                      else
                      Goto, logoutcoinsequence

                }



finishinvcheck:

        Random, minrand, 150, 250
        Random, smallrand, 185, 225
        Random, midrand, 150, 300
        Random, bigrand, 245, 355
        SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
        Random, randchoice, 1, 8
        Sleep, SleepTimes[randchoice]
				Random, randchoice, 1, 8
				Sleep, SleepTimes[randchoice]

        loop 25
        {
        PixelSearch, X62, Y62, XStart+722, YStart+102, XStart+727, YStart+105, 0x131313, 4, Fast ; checking if health dropped
        if Errorlevel = 1
        {}
        else
          GoTo, teleportasap
        }

        Loop 1000
        {
        PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x1F2876, 10, Fast ; checking if spellbook open
            if Errorlevel = 1
						PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x0D1134, 10, Fast ; checking if spellbook open
								if Errorlevel = 1
            {
							Random, minrand, 150, 250
							Random, smallrand, 185, 225
							Random, midrand, 150, 300
							Random, bigrand, 245, 355
							SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
							Random, randchoice, 1, 8
							Sleep, SleepTimes[randchoice]
          Controlclick, x34 y346, BlueStacks,,,, NA ; open spellbook
					Random, randchoice, 1, 8
					Sleep, SleepTimes[randchoice]
					Random, randchoice, 1, 8
					Sleep, SleepTimes[randchoice]
					Random, randchoice, 1, 8
					Sleep, SleepTimes[randchoice]
              }
            else
                Goto, clickhometele
      }

      clickhometele:
sleep, 350
      Random, minrand, 150, 250
      Random, smallrand, 185, 225
      Random, midrand, 150, 300
      Random, bigrand, 245, 355
      SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
      Random, randchoice, 1, 8
      Sleep, SleepTimes[randchoice]

      Controlclick, x155 y324, BlueStacks,,,, NA ; click home teleport

      opensettt1:
sleep, 350
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
opensettingsagain:
            Controlclick, x876 y464, BlueStacks,,,, NA ; open settings




						Loop 15
						{
						PixelSearch, X62, Y62, XStart+862, YStart+448, XStart+887, YStart+479, 0x1A236A, 10, Fast ; checking if settings is open
						if Errorlevel = 1
						PixelSearch, X62, Y62, XStart+862, YStart+448, XStart+887, YStart+479, 0x111641, 10, Fast ; checking if settings is open
						if Errorlevel = 1
						PixelSearch, X62, Y62, XStart+862, YStart+448, XStart+887, YStart+479, 0x1B246C, 10, Fast ; checking if settings is open
						if Errorlevel = 1
						sleep 1
						else
							GoTo, movingon243432
						}
						Goto, opensettingsagain

						movingon243432:

sleep, 500
            Random, minrand, 150, 250
            Random, smallrand, 185, 225
            Random, midrand, 150, 300
            Random, bigrand, 245, 355
            SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
            Random, randchoice, 1, 8
            Sleep, SleepTimes[randchoice]

            clickhouseoptions:
            Controlclick, x780 y493, BlueStacks,,,, NA ; click house options

            Loop 5
            {
            PixelSearch, X62, Y62, XStart+708, YStart+257, XStart+804, YStart+270, 0x1A81D8, 10, Fast ; checking if house options open
            if Errorlevel = 1
            PixelSearch, X62, Y62, XStart+708, YStart+257, XStart+804, YStart+270, 0x1C8AE8, 10, Fast ; checking if house options open
            if Errorlevel = 1
            sleep 1
            else
              GoTo, callservant
            }
            Goto, clickhouseoptions

callservant:
sleep, 150
Controlclick, x754 y479, BlueStacks,,,, NA ; Click call serv

loop 25
{
PixelSearch, X62, Y62, XStart+722, YStart+102, XStart+727, YStart+105, 0x131313, 4, Fast ; checking if health dropped
if Errorlevel = 1
{}
else
  GoTo, teleportasap
}

Loop 10
{
PixelSearch, X62, Y62, XStart+109, YStart+70, XStart+127, YStart+88, 0x195056, 5, Fast ; checking if interface open
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+109, YStart+70, XStart+127, YStart+88, 0x2D5741, 5, Fast ; checking if interface open
if Errorlevel = 1
sleep 10
else
Goto, clicksawmill
}

sleep, 500

clickdemonbut:
CoordMode, pixel, Client
WinGet, winid ,, A ; Get current Window ID
BlockInput, On
  WinActivate, BlueStacks
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x455595, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x3F508C, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x42518F, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x182C75, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x46487C, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x182A70, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x364577, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x1F2A54, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x092047, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x213168, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x1E2855, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x3B4B84, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x3D4D87, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x24317E, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x40508E, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x3D4E88, 1, Fast
if Errorlevel = 1
PixelSearch, X62, Y62, 390, 196, 541, 379, 0x2C407B, 1, Fast
if Errorlevel = 1
{
WinActivate ahk_id %winid% ; Activate Old Window
BlockInput, Off
CoordMode, Pixel, screen
goto, clickdemonbut
}
Else

WinActivate ahk_id %winid% ; Activate Old Window
BlockInput, Off
CoordMode, Pixel, screen


    Controlclick, x%X62% y%Y62%, BlueStacks,,,, NA ; clickdemonbut
sleep, 300

loop 25
{
PixelSearch, X62, Y62, XStart+722, YStart+102, XStart+727, YStart+105, 0x131313, 4, Fast ; checking if health dropped
if Errorlevel = 1
{}
else
  GoTo, teleportasap
}
Goto, checkforstandarddialogue

checkforstandarddialogue2:
Controlclick, x325 y162, BlueStacks,,,, NA ; paying butler third dialogue continue
sleep 500
checkforstandarddialogue:
    Loop 20
    {
		PixelSearch, X62, Y62, XStart+109, YStart+70, XStart+127, YStart+88, 0x195056, 5, Fast ; checking if interface open
		if Errorlevel = 1
		PixelSearch, X62, Y62, XStart+109, YStart+70, XStart+127, YStart+88, 0x2D5741, 5, Fast ; checking if interface open
		if Errorlevel = 1
    sleep 10
    else
    Goto, clicksawmill
    }
    Goto, checkifbutlerneedstobepaid

clicksawmill:
sleep, 400
Controlclick, x277 y111, BlueStacks,,,, NA ; click take to sawmill

Loop 50
{
PixelSearch, X62, Y62, XStart+244, YStart+149, XStart+397, YStart+171, 0xE0353A, 10, Fast ; checking if second dialogue
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+244, YStart+149, XStart+397, YStart+171, 0xFB0608, 10, Fast ; checking if second dialogue
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+244, YStart+149, XStart+397, YStart+171, 0xEC2427, 10, Fast ; checking if second dialogue
if Errorlevel = 1
sleep 10
else
Goto, clickcontinue2
}
soundbeep
Goto, clickdemonbut

clickcontinue2:
Controlclick, x306 y162, BlueStacks,,,, NA ; click to continue

Loop 50
{
PixelSearch, X62, Y62, XStart+34, YStart+68, XStart+59, YStart+85, 0x195459, 10, Fast ; checking if third dialogue
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+34, YStart+68, XStart+59, YStart+85, 0x195459, 10, Fast ; checking if third dialogue
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+34, YStart+68, XStart+59, YStart+85, 0x425928, 10, Fast ; checking if third dialogue
if Errorlevel = 1
sleep 10
else
Goto, clickcontinue3
}
soundbeep
Goto, clickdemonbut

clickcontinue3:
Controlclick, x278 y106, BlueStacks,,,, NA ; click yes

Loop 50
{
	PixelSearch, X62, Y62, XStart+244, YStart+149, XStart+397, YStart+171, 0xE0353A, 10, Fast ; checking if fourth dialogue
	if Errorlevel = 1
	PixelSearch, X62, Y62, XStart+244, YStart+149, XStart+397, YStart+171, 0xFB0608, 10, Fast ; checking if fourth dialogue
	if Errorlevel = 1
	PixelSearch, X62, Y62, XStart+244, YStart+149, XStart+397, YStart+171, 0xEC2427, 10, Fast ; checking if fourth dialogue
	if Errorlevel = 1
sleep 10
else
Goto, clickcontinue4
}
soundbeep
Goto, clickdemonbut

clickcontinue4:

Controlclick, x306 y162, BlueStacks,,,, NA ; click to continue

sleep, 200
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

teleporttocamagain:
loop 15
{
PixelSearch, X62, Y62, XStart+722, YStart+102, XStart+727, YStart+105, 0x131313, 4, Fast ; checking if health dropped
if Errorlevel = 1
{}
else
  GoTo, teleportasap
}

Loop
{
PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x1F2876, 10, Fast ; checking if spellbook open
		if Errorlevel = 1
		PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x0D1134, 10, Fast ; checking if spellbook open
				if Errorlevel = 1
		{
			Random, minrand, 150, 250
			Random, smallrand, 185, 225
			Random, midrand, 150, 300
			Random, bigrand, 245, 355
			SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
			Random, randchoice, 1, 8
			Sleep, SleepTimes[randchoice]
	Controlclick, x34 y346, BlueStacks,,,, NA ; open spellbook
	Random, minrand, 150, 250
	Random, smallrand, 185, 225
	Random, midrand, 150, 300
	Random, bigrand, 245, 355
	SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
	Random, randchoice, 1, 8
	Sleep, SleepTimes[randchoice]
	Random, randchoice, 1, 8
	Sleep, SleepTimes[randchoice]
	Random, randchoice, 1, 8
	Sleep, SleepTimes[randchoice]
			}
		else
        Goto, clicklumtele
}


clicklumtele:
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]
Controlclick, x223 y325, BlueStacks,,,, NA ; Click teleport to camelot

sleep, 750



loop 1500
                            {
                                PixelSearch, X62, Y62, XStart+227, YStart+146, XStart+378, YStart+163, 0xE23439, 5, Fast ; checking for 'click to continue'
                                if Errorlevel = 0
                                {

                                  WinGet, winid ,, A ; Get current Window ID
                                  BlockInput, On
                                    WinActivate, BlueStacks
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    ControlSend, , {Space}, BlueStacks
                                    sleep 1500
                                    WinActivate ahk_id %winid% ; Activate Old Window
                                    BlockInput, Off
                                    Goto, loopcont
                                }
                                else

                                Goto, loopcont
                                }
loopcont:


sleep, 500

Goto, beginloop

;******************************PAY BUTLER SEQUENCE**********************
checkifbutlerneedstobepaid:
Loop 50
{
PixelSearch, X62, Y62, XStart+142, YStart+113, XStart+179, YStart+128, 0x821A1D, 5, Fast ; check if butler needs to be paid (dialogue)
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+142, YStart+113, XStart+179, YStart+128, 0x82181A, 5, Fast ; check if butler needs to be paid (dialogue)
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+142, YStart+113, XStart+179, YStart+128, 0x84272A, 5, Fast ; check if butler needs to be paid (dialogue)
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+142, YStart+113, XStart+179, YStart+128, 0x843237, 5, Fast ; check if butler needs to be paid (dialogue)
if Errorlevel = 1
sleep 10
else
Goto, paythebutler
}
soundbeep
Goto, clickdemonbut

paythebutler:
Controlclick, x321 y163, BlueStacks,,,, NA ; paying butler first dialogue continue

Loop 50
{
PixelSearch, X62, Y62, XStart+181, YStart+92, XStart+367, YStart+112, 0x242C30, 5, Fast ; pay butler second dialogue
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+142, YStart+113, XStart+179, YStart+128, 0x1F262A, 5, Fast ; pay butler second dialogue
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+142, YStart+113, XStart+179, YStart+128, 0x1E2428, 5, Fast ; pay butler second dialogue
if Errorlevel = 1
PixelSearch, X62, Y62, XStart+142, YStart+113, XStart+179, YStart+128, 0x1E2428, 5, Fast ; pay butler second dialogue
if Errorlevel = 1
sleep 10
else
Goto, paythebutlerthirddialogue
}
soundbeep
Goto, clickdemonbut

paythebutlerthirddialogue:
Controlclick, x275 y103, BlueStacks,,,, NA ; paying butler second dialogue continue

Loop 50
{
	PixelSearch, X62, Y62, XStart+448, YStart+109, XStart+501, YStart+128, 0x823439, 10, Fast ; pay butler third dialogue
	if Errorlevel = 1
	PixelSearch, X62, Y62, XStart+448, YStart+109, XStart+501, YStart+128, 0x88535B, 10, Fast ; pay butler third dialogue
	if Errorlevel = 1
	PixelSearch, X62, Y62, XStart+448, YStart+109, XStart+501, YStart+128, 0x822022, 10, Fast ; pay butler third dialogue
	if Errorlevel = 1
	PixelSearch, X62, Y62, XStart+448, YStart+109, XStart+501, YStart+128, 0x842A2F, 10, Fast ; pay butler third dialogue
	if Errorlevel = 1
	PixelSearch, X62, Y62, XStart+448, YStart+109, XStart+501, YStart+128, 0x844249, 10, Fast ; pay butler third dialogue
	if Errorlevel = 1
sleep 10
else
Goto, checkforstandarddialogue2
}
soundbeep
Goto, clickdemonbut

;************************************LOGOUT LOG SEQUENCE***************************
logoutlogsequence:
Loop 1000
{
PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x1F2876, 10, Fast ; checking if spellbook open
    if Errorlevel = 1
    PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x0D1134, 10, Fast ; checking if spellbook open
        if Errorlevel = 1
    {
      sleep, 300
  Controlclick, x34 y346, BlueStacks,,,, NA ; open spellbook
  sleep, 100
  goto, clickcammytelelog
      }
    else
        Goto, clickcammytelelog
}

clickcammytelelog:
sleep, 400
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x223 y323, BlueStacks,,,, NA ; click camelot teleport
sleep, 5000
Controlclick, x878 y503, BlueStacks,,,, NA ; click logout tab
sleep, 1500
Controlclick, x758 y482, BlueStacks,,,, NA ; click (Tap here to logout)
sleep, 1500
MsgBox, 4096, LOGGED OUT, You have been logged out! The script has stopped! Failed to find: NOTED LOGS
reload
return

;**************************EXIT BANK*************************
exitbank:
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

loop 25
{
PixelSearch, X62, Y62, XStart+722, YStart+102, XStart+727, YStart+105, 0x131313, 4, Fast ; checking if health dropped
if Errorlevel = 1
{}
else
  GoTo, teleportasap
}

Controlclick, x611 y216, BlueStacks,,,, NA ; EXIT BANK

loop 25
{
PixelSearch, X62, Y62, XStart+722, YStart+102, XStart+727, YStart+105, 0x131313, 4, Fast ; checking if health dropped
if Errorlevel = 1
{}
else
  GoTo, teleportasap
}

sleep, 400
Random, minrand, 285, 350
Random, smallrand, 285, 325
Random, midrand, 300, 500
Random, bigrand, 500, 1000
Random, checkrand, 1, 3
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand,9:checkrand,10:checkrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

goto, beginloop


;*******************************DAMAGE DETECTION TELEPORT**********************
teleportasap:
Loop 1000
{
PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x1F2876, 10, Fast ; checking if spellbook open
    if Errorlevel = 1
    PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x0D1134, 10, Fast ; checking if spellbook open
        if Errorlevel = 1
    {
      sleep, 300
  Controlclick, x34 y346, BlueStacks,,,, NA ; open spellbook
  sleep, 100
  goto, clickcammytele
      }
    else
        Goto, clickcammytele
}

clickcammytele:
sleep, 400
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x223 y323, BlueStacks,,,, NA ; click camelot teleport

loop 3
{
soundbeep
}
sec:=60
ToolTip, Player damage detected! %sec% second/s until attempting to continue., (x + 20), (y + 20), 1
soundbeep
SetTimer, RemoveToolTip, 1000

RemoveToolTip:
sec -=1
if %sec% >= 0
{
SetTimer,RemoveToolTip,Off
Goto, beginloop
ToolTip
}
else
ToolTip, Player damage detected! %sec% second/s until attempting to continue., (x + 20), (y + 20), 1
soundbeep
return

;********************************************LOGOUT RUNE SEQUENCE***********************
logoutrunesequence:
Loop 1000
{
PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x1F2876, 10, Fast ; checking if spellbook open
    if Errorlevel = 1
    PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x0D1134, 10, Fast ; checking if spellbook open
        if Errorlevel = 1
    {
      sleep, 300
  Controlclick, x34 y346, BlueStacks,,,, NA ; open spellbook
  sleep, 100
  goto, clickcammytelelog2
      }
    else
        Goto, clickcammytelelog2
}

clickcammytelelog2:
sleep, 400
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x223 y323, BlueStacks,,,, NA ; click camelot teleport
sleep, 5000
Controlclick, x878 y503, BlueStacks,,,, NA ; click logout tab
sleep, 1500
Controlclick, x758 y482, BlueStacks,,,, NA ; click (Tap here to logout)
sleep, 1500
MsgBox, 4096, LOGGED OUT, You have been logged out! The script has stopped! Failed to find: RUNES
reload
return
;**********************************************LOGOUT COIN SEQUENCE************************************
logoutcoinsequence:
Loop 1000
{
PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x1F2876, 10, Fast ; checking if spellbook open
    if Errorlevel = 1
    PixelSearch, X62, Y62, XStart+17, YStart+330, XStart+46, YStart+362, 0x0D1134, 10, Fast ; checking if spellbook open
        if Errorlevel = 1
    {
      sleep, 300
  Controlclick, x34 y346, BlueStacks,,,, NA ; open spellbook
  sleep, 100
  goto, clickcammytelelog3
      }
    else
        Goto, clickcammytelelog3
}

clickcammytelelog3:
sleep, 400
Random, minrand, 150, 250
Random, smallrand, 185, 225
Random, midrand, 150, 300
Random, bigrand, 245, 355
SleepTimes:={1:minrand,2:minrand,3:minrand,4:smallrand,5:smallrand,6:midrand,7:midrand,8:bigrand}
Random, randchoice, 1, 8
Sleep, SleepTimes[randchoice]

Controlclick, x223 y323, BlueStacks,,,, NA ; click camelot teleport
sleep, 5000
Controlclick, x878 y503, BlueStacks,,,, NA ; click logout tab
sleep, 1500
Controlclick, x758 y482, BlueStacks,,,, NA ; click (Tap here to logout)
sleep, 1500
MsgBox, 4096, LOGGED OUT, You have been logged out! The script has stopped! Failed to find: COINS.
reload
return
