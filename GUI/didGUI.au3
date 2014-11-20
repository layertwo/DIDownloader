Func _createGUI()

Dim $height = 275
Dim $width = 500

; GUI Create
GUICreate("DIDownloader", $width, $height)
GUISetIcon("DIDownloader.exe", 0)

; InputBox
Global $iLink = GUICtrlCreateInput("", 5, 30, $width - 155, 25)

; Buttons
Global $bGo = GUICtrlCreateButton("&Go", $width - 147, 30, 70, 25)
Global $bClear = GUICtrlCreateButton("Clear", $width - 75, 30, 70, 25)

; Create dummy control for when Enter key is pressed
$kEnter = GUICtrlCreateDummy()
Dim $aEnter[1][2] = [["{ENTER}", $kEnter]]
GUISetAccelerators($aEnter)

; OutputBox
Global $oList = GUICtrlCreateList("", 5, 60, $width - 10, 200, BitOr($WS_VSCROLL, $WS_BORDER))

; Labels
GUICtrlCreateLabel("Paste Driver Identifier link below:", 5, 8)
GUICtrlCreateLabel("DIDownloader v" & $prodVer & " | Updated " & $modified, 5, $height - 20)

; GUI MESSAGE LOOP
GUISetState(@SW_SHOW)
   While 1
	  Switch GUIGetMsg()

	  Case $GUI_EVENT_CLOSE

			_deleteExtracter()
			Exit

		 Case $bGo, $kEnter

			; Clear list
			GUICtrlSetData($oList, "")

			$tbLink = GUICtrlRead($iLink)
			_convertLink()

			If $validLink = True Then
			   _downloadFile()

			EndIf

		 Case $bClear

			; Clear box
			GUICtrlSetData($iLink, "")

			; Clear list
			GUICtrlSetData($oList, "")

			; Clear variables
			$tbLink = ""
			$fileLink = ""
			$fileName = ""
			$validLink = False

	  EndSwitch

   WEnd

EndFunc