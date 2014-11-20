#NoTrayIcon
#include <InetConstants.au3>
#include <file.au3>
#include <MsgBoxConstants.au3>

Global $title
Global $localVer
Global $latestVer
Global $latestLink
Global $tempFile = @TempDir & '\'

Func _checkFileVersion()
   ; Retrieve the file version of the AutoIt executable.
   $localVer = $fileVer

   ; Download latest version from link
   Dim $downName = _lastSlash()
   Dim $fileVerGet = InetGet($latestLink, $TempFile & $downName)
   InetClose($fileVerGet)

   ; Get version of the latest
   $latestVer = FileGetVersion($TempFile & $downName)

   If $latestVer > $localVer then
	  ; New version found, asks user if they would like to update
	  $updateResponse = MsgBox(3, "New version available", "New version " & $latestVer & " is available. The currently running version is " & $localVer & ". Would you like to update to the latest version?")

		 ; If response is Yes
		 If $updateResponse = 6 Then

			; Move downloaded file from temp directory to running directory
			FileMove($TempFile & $downName, @AutoItExe, 1)

			MsgBox(1, "Version updated", $title & " has been updated. Please relaunch application.")
			Exit

		 EndIf
   EndIf

EndFunc

Func _lastSlash()
   Local $origLink = $latestLink
   Local $endSlash = StringInStr($origLink, "/", 0, -1)
   Local $newLink = StringTrimLeft($origLink, $endSlash)

EndFunc