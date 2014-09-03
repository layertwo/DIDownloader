; DIDownloader
; Author: Lucas Messenger
$prodVer = "0.2"
$fileVer = "0.2.0.2"
; Created: 6/6/2014
$modified = "9/2/2014"
; ---------------------------------
; Link parser and downloader for DriverIdentifier links
; ---------------------------------
; Icon: http://www.iconspedia.com/icon/resources-icon-35731.html
; CC Attribution license for icon: https://creativecommons.org/licenses/by/3.0/

#pragma compile(FileDescription, Link parser and file downloader)
#pragma compile(ProductName, DIDownloader)
#pragma compile(ProductVersion, 0.2)
#pragma compile(FileVersion, 0.2.0.2)
#pragma compile(LegalCopyright, 2014 - Lucas Messenger)


#NoTrayIcon
#include <GuiConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <file.au3>
#include <ListBoxConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <GUIButton.au3>
#include <GuiEdit.au3>
#include <GUIListBox.au3>
#include <InetConstants.au3>
#include "updater.au3"

Global $latestLink = "https://github.com/lmessenger/DIDownloader/raw/master/DIDownloader.exe"
Global $download = @UserProfileDir & '\Downloads\Drivers'
Global $tbLink
Global $fileLink
Global $fileName
Global $validLink = False

Dim $height = 275
Dim $width = 450

_checkFileVersion()

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
GUICtrlCreateLabel("DIDownloader v" & $prodVer & " | Updated " & $modified, 5, $height - 20)

; GUI MESSAGE LOOP
GUISetState(@SW_SHOW)
   While 1
	  Switch GUIGetMsg()
		 Case $GUI_EVENT_CLOSE
			Exit

		 Case $bGo
			$tbLink = GUICtrlRead($iLink)
			convertLink()
			If $validLink = True Then
			   downloadFile()
			EndIf
	  EndSwitch
   WEnd

   Func convertLink()
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

Func downloadFile()

		 _GUICtrlListBox_BeginUpdate($oList)
		 _GUICtrlListBox_AddString($oList, "Downloading " & $fileLink & "... 0%")
		 _GUICtrlListBox_EndUpdate($oList)

		 DirCreate($download)

		 Dim $fileGet = InetGet($fileLink, $download & '\' & $fileName, 8, 1)
		 $serverSize = InetGetSize($fileLink, 2)
		 If InetGetSize($fileLink, 2) = 0 Then
			GUICtrlSetData($oList, "DOWNLOAD ERROR. File may not exist, or website is down.")
		 Else

		 Do
			_GUICtrlListBox_BeginUpdate($oList)
			$fileSize = InetGetInfo($fileGet, 0)
			_GUICtrlListBox_DeleteString($oList, _GUICtrlListBox_GetCount($oList) - 1)
			_GUICtrlListBox_AddString($oList, "Downloading " & $fileLink & "... " & Round((($fileSize/$serverSize) * 100), 0) & "%")
			_GUICtrlListBox_EndUpdate($oList)
			Sleep(50)
		 Until InetGetInfo($fileGet, 2)

		 InetClose($fileGet)

		 _GUICtrlListBox_BeginUpdate($oList)
		 _GUICtrlListBox_DeleteString($oList, _GUICtrlListBox_GetCount($oList) - 1)
		 Sleep(10)
		 _GUICtrlListBox_AddString($oList, "Downloading " & $fileLink & "... 100%")
		 _GUICtrlListBox_EndUpdate($oList)
	  EndIf
   EndFunc
