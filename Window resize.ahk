+F1::
WinExist("BlueStacks")
WinGetPos, X, Y, Width, Height, BlueStacks
WinGetPos,,, sizeX, sizeY
        WinMove, BlueStacks,, %X%, %Y%, 800, 600
msgbox, 4096, BlueStacks, The BlueStacks window has been resized to the correct size. You can now move the BlueStacks window. (Recommended: Out of the way, but still visible)
return

