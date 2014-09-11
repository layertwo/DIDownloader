Func _createGUI()

FileInstall("exec\7za.exe", @UserProfileDir & "\Downloads\7za.exe")

Dim $height = 275
Dim $width = 450

; GUI Create
GUICreate("DIDownloader", $width, $height)
GUISetIcon("DIDownloader.exe", 0)

; InputBox
Global $iLink = GUICtrlCreateInput("", 5, 30, 355, 25)

; Buttons
Global $bGo = GUICtrlCreateButton("&Go", $width - 85, 30, 80, 25)

; OutputBox
Global $oList = GUICtrlCreateList("", 5, 60, 440, 200, BitOr($WS_VSCROLL, $WS_BORDER))

; Labels
GUICtrlCreateLabel("Paste Driver Identifier link below:", 5, 8)
GUICtrlCreateLabel("DIDownloader v" & $prodVer & " | Updated " & $modified, 5, $height - 20)

; GUI MESSAGE LOOP
GUISetState(@SW_SHOW)
   While 1
	  Switch GUIGetMsg()
		 Case $GUI_EVENT_CLOSE
			Exit

		 Case $bGo
			$tbLink = GUICtrlRead($iLink)
			_convertLink()
			If $validLink = True Then
			   _downloadFile()
			EndIf
	  EndSwitch
   WEnd

EndFunc