;----------------------------PLACE THIS AT TOP OF SCRIPT SO IT READS INI FILE EVERYTIME SCRIPT OPENS------------------------------------------
FileCreateDir, Essentials
IniRead, DesPosX, Essentials\Coordinates.ini, StandardCoord, StandardXCord
IniRead, DesPosY, Essentials\Coordinates.ini, StandardCoord, StandardYCord





;-------------------------------------HOTKEY TO DESIGNATE COORD------------------------------------------
+F3::  ;  Designate Coord With Shift F3
	IfWinExist, BlueStacks
	WinActivate, BlueStacks
MouseGetPos, DesPosX, DesPosY
IniWrite, %DesPosX%, Essentials\Coordinates.ini, StandardCoord, StandardXCord
IniWrite, %DesPosY%, Essentials\Coordinates.ini, StandardCoord, StandardYCord
soundbeep
return



;-------------------------------------EXAMPLE HOW TO USE------------------------------------------
		    Controlclick, x%DesPosX% y%DesPosY%, BlueStacks,,,, NA ; open bank
