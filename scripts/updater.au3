#NoTrayIcon
#include <InetConstants.au3>
#include <file.au3>
#include <MsgBoxConstants.au3>

Global $localVer
Global $latestVer
Global $latestLink
Global $tempFile = @TempDir & '\'

Func _checkFileVersion()
   ; Retrieve the file version of the AutoIt executable.
   $localVer = $fileVer

   ; Download latest version from link
   Dim $downName = _lastSlash()
   Dim $fileVerGet = InetGet($latestLink, @TempDir & '\' & $downName)
   InetClose($fileVerGet)

   ; Get version of the latest
   $latestVer = FileGetVersion(@TempDir & '\' & $downName)

   If $latestVer > $localVer then
	  MsgBox($MB_SYSTEMMODAL, "", "New version " & $latestVer & " is available. Currently running is " & $localVer & '.')
   EndIf

EndFunc

Func _lastSlash()
   Local $origLink = $latestLink
   Local $endSlash = StringInStr($origLink, "/", 0, -1)
   Local $newLink = StringTrimLeft($origLink, $endSlash)

EndFunc