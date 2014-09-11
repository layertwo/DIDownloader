Func _downloadFile()

		 _GUICtrlListBox_BeginUpdate($oList)
		 _GUICtrlListBox_AddString($oList, "Downloading " & $fileName & "... 0%")
		 _GUICtrlListBox_EndUpdate($oList)

		 DirCreate($download)

		 Dim $fileGet = InetGet($fileLink, $download & '\' & $fileName, 8, 1)
		 $serverSize = InetGetSize($fileLink, 2)
		 If InetGetSize($fileLink, 2) = 0 Then
			GUICtrlSetData($oList, "A download error has occured. File may not exist, or website is down.")
		 Else

		 Do
			_GUICtrlListBox_BeginUpdate($oList)
			$fileSize = InetGetInfo($fileGet, 0)
			_GUICtrlListBox_DeleteString($oList, _GUICtrlListBox_GetCount($oList) - 1)
			_GUICtrlListBox_AddString($oList, "Downloading " & $fileName & "... " & Round((($fileSize/$serverSize) * 100), 0) & "%")
			_GUICtrlListBox_EndUpdate($oList)
			Sleep(50)
		 Until InetGetInfo($fileGet, 2)

		 InetClose($fileGet)

		 _GUICtrlListBox_BeginUpdate($oList)
		 _GUICtrlListBox_DeleteString($oList, _GUICtrlListBox_GetCount($oList) - 1)
		 Sleep(10)
		 _GUICtrlListBox_AddString($oList, "Downloading " & $fileLink & "... 100%")
		 _GUICtrlListBox_EndUpdate($oList)

		 $lastPeriod = StringInStr($fileName, ".", 0, -1)
		 $fileType = StringTrimLeft($fileName, $lastPeriod -1)

		 If $fileType = ".zip" Then
			_extractArchive("zip")
		 ElseIf $fileType = ".rar" Then
			_extractArchive(".rar")
		 EndIf


	  EndIf
   EndFunc