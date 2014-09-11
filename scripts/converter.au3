Func _convertLink()

   If StringInStr($tbLink, "www.driveridentifier.com/scan/download_file.php?url=") <> 0 Then
		 If StringRegExp($tbLink, "https://") = True Then
			$fileLinkStart = StringLen("https://www.driveridentifier.com/scan/download_file.php?url=")
		 ElseIf StringRegExp($tbLink, "http://") = true Then
			$fileLinkStart = StringLen("http://www.driveridentifier.com/scan/download_file.php?url=")
		 EndIf

		 $fileLink = StringTrimLeft($tbLink, $fileLinkStart)
		 $hardwareStr = StringInStr($fileLink, "&hardware_id=")
		 $strCount = StringLen($fileLink)

		 $fileLink = StringTrimRight($fileLink, Abs($hardwareStr - $strCount - 1))
		 $fileLink = StringReplace($fileLink, "%3A", ":")
		 $fileLink = StringReplace($fileLink, "%2F", "/")

		 $lastSlash = StringInStr($fileLink, "/", 0, -1)
		 $fileName = StringTrimLeft($fileLink, $lastSlash)

		 _GUICtrlListBox_BeginUpdate($oList)
		 _GUICtrlListBox_AddString($oList, "Decoded: " & $fileLink)
		 _GUICtrlListBox_AddString($oList, "")
		 _GUICtrlListBox_EndUpdate($oList)

		 $validLink = True
   Else

	  GUICtrlSetData($oList, "Invalid entry.")
	  $validLink = False
   EndIf

EndFunc