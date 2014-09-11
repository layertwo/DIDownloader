Global $archive

Func _extractArchive(ByRef $type)
   If $type = ".zip" Then
	  RunWait(@ComSpec & " /k " & @UserProfileDir & "\Downloads\7za.exe x " & $download & '\' & $fileName & " -o" & $download, "")
   ElseIf $type = ".rar" Then
	  RunWait(@ComSpec & " /k " & @UserProfileDir & "\Downloads\7za.exe e " & $download & '\' & $fileName & " -o" & $download, "")
   FileDelete($download & '\' & $fileName)
   EndIf
EndFunc