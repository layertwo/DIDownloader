; DIDownloader
; Author: Lucas Messenger
$version = "0.1"
; Created: 6/6/2014
$modified = "6/7/2014"
; ---------------------------------
; Link parser and downloader for DriverIdentifier links


#include <GuiConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <file.au3>
#include <Array.au3>
#include <ListBoxConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <GUIButton.au3>
#include <GuiEdit.au3>
#include <GUIListBox.au3>

Dim $download = @UserProfileDir & '\Downloads'

Dim $height = 275
Dim $width = 450

Global $input
Global $output
Global $fileName

; GUI Create
GUICreate("DIDownloader", $width, $height)
GUISetIcon("DIDownloader.exe", 0)

; InputBox
Dim $iLink = GUICtrlCreateInput("", 5, 30, 355, 25)

; Buttons
Dim $bGo = GUICtrlCreateButton("&Go", $width - 85, 30, 80, 25)

; OutputBox
Dim $oList = GUICtrlCreateList("", 5, 60, 440, 200, BitOr($WS_VSCROLL, $WS_BORDER))

; Labels
GUICtrlCreateLabel("Paste Driver Identifier link below:", 5, 8)
GUICtrlCreateLabel("DIDownloader v" & $version & " | Updated " & $modified, 5, $height - 20)

; GUI MESSAGE LOOP
GUISetState(@SW_SHOW)
   While 1
	  Switch GUIGetMsg()
		 Case $GUI_EVENT_CLOSE
			Exit

		 Case $bGo
			$input = GUICtrlRead($iLink)
			convertLink()
			downloadFile()
	  EndSwitch
   WEnd

;	http://www.driveridentifier.com/scan/download_file.php?url=ftp%3A%2F%2Fftp.hp.com%2Fpub%2Fsoftpaq%2Fsp57001-57500%2Fsp57362.exe&hardware_id=HDAUDIO%5CFUNC_01%26VEN_8086%26DEV_2805%26SUBSYS_80860101&driver_inf_file_id=1148560&scanid=9B21BBF9177F4517BE80C8D06A612834


   Func convertLink()

	  If StringRegExp($input, "https://") = True Then
		 $linkStart = StringLen("https://www.driveridentifier.com/scan/download_file.php?url=")
	  ElseIf StringRegExp($input, "http://") = true Then
		 $linkStart = StringLen("http://www.driveridentifier.com/scan/download_file.php?url=")
	  EndIf

	  $output = StringTrimLeft($input, $linkStart)
	  $hardwareStr = StringInStr($output, "&hardware_id=")
	  $strCount = StringLen($output)

	  $output = StringTrimRight($output, Abs($hardwareStr - $strCount - 1))
	  $output = StringReplace($output, "%3A", ":")
	  $output = StringReplace($output, "%2F", "/")
	  $output = StringStripWS($output, 8)

	  $lastSlash = StringInStr($output, "/", 0, -1)
	  $fileName = StringTrimLeft($output, $lastSlash)

EndFunc

Func downloadFile()
	  _GUICtrlListBox_BeginUpdate($oList)
	  _GUICtrlListBox_AddString($oList, "Decoded: " & $output)
	  _GUICtrlListBox_AddString($oList, "")
	  _GUICtrlListBox_AddString($oList, "Downloading " & $output & "... 0%")
	  Dim $fileGet = InetGet($output, $download & '\' & $fileName, 8, 1)
	  $serverSize = InetGetSize($output, 2)
	  _GUICtrlListBox_EndUpdate($oList)

	  Do
		 _GUICtrlListBox_BeginUpdate($oList)
		 $fileSize = InetGetInfo($fileGet, 0)
		 _GUICtrlListBox_DeleteString($oList, _GUICtrlListBox_GetCount($oList) - 1)
		 Sleep(50)
		 _GUICtrlListBox_AddString($oList, "Downloading " & $output & "... " & Round((($fileSize/$serverSize) * 100), 0) & "%")
		 _GUICtrlListBox_EndUpdate($oList)
		 sleep(50)
	  Until InetGetInfo($fileGet, 2)

	  InetClose($fileGet)

	  _GUICtrlListBox_BeginUpdate($oList)
	  _GUICtrlListBox_DeleteString($oList, _GUICtrlListBox_GetCount($oList) - 1)
	  Sleep(10)
	  _GUICtrlListBox_AddString($oList, "Downloading " & $output & "... 100%")
	  _GUICtrlListBox_EndUpdate($oList)

   EndFunc
