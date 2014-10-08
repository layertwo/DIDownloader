Global $archive

Func _extractArchive(ByRef $type)

	  _GUICtrlListBox_BeginUpdate($oList)
	  _GUICtrlListBox_AddString($oList, "Archive has been detected, currrently extracting...")
	  _GUICtrlListBox_EndUpdate($oList)

	  _GUICtrlListBox_BeginUpdate($oList)
   If $type = ".zip" Then

	  RunWait(@ComSpec & " /c " & @UserProfileDir & "\Downloads\Drivers\7za.exe x " & $download & '\' & $fileName & " -o" & $download & "\" & $fileText & " -aoa", "", @SW_HIDE)
	  _GUICtrlListBox_AddString($oList, $fileName & " has been extracted.")

   ; Still in progress, is not properly extracting with
   ;ElseIf $type = ".rar" Then
	  ;RunWait(@ComSpec & " /k " & @UserProfileDir & "\Downloads\7za.exe e " & $download & '\' & $fileName & " -o" & $download, "")
   EndIf

   FileDelete($download & '\' & $fileName)
   	  _GUICtrlListBox_EndUpdate($oList)

EndFunc

Func _deleteExtracter()

   If FileExists(@UserProfileDir & "\Downloads\Drivers\7za.exe") Then
	  FileDelete(@UserProfileDir & "\Downloads\Drivers\7za.exe")
   EndIf

EndFunc