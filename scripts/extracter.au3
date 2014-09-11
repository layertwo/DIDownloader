Global $archive

Func _extractArchive(ByRef $type)

	  _GUICtrlListBox_BeginUpdate($oList)
	  _GUICtrlListBox_AddString($oList, "Archive has been detected, currrently extracting...")

   If $type = ".zip" Then

	  RunWait(@ComSpec & " /k " & @UserProfileDir & "\Downloads\7za.exe x " & $download & '\' & $fileName & " -o" & $download, "")
	  _GUICtrlListBox_AddString($oList, $fileName & " has been extracted.")

   ; Still in progress, is not properly extracting with
   ;ElseIf $type = ".rar" Then
	  ;RunWait(@ComSpec & " /k " & @UserProfileDir & "\Downloads\7za.exe e " & $download & '\' & $fileName & " -o" & $download, "")
   EndIf

   FileDelete($download & '\' & $fileName)
   	  _GUICtrlListBox_EndUpdate($oList)

EndFunc

Func _deleteExtracter()

   If FileExists(@UserProfileDir & "\Downloads\7za.exe") Then
	  FileDelete(@UserProfileDir & "\Downloads\7za.exe")
   EndIf

EndFunc