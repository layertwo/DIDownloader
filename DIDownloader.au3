$title = "DIDownloader"
; Author: Lucas Messenger
$prodVer = "0.3.0"
$fileVer = "0.3.0.0"
; Created: 6/6/2014
$modified = "9/15/2014"
; ---------------------------------
; Link parser and downloader for DriverIdentifier links
; ---------------------------------
; Icon: http://www.iconspedia.com/icon/resources-icon-35731.html
; CC Attribution license for icon: https://creativecommons.org/licenses/by/3.0/
;
; 7-zip is used as the extraction utility.
; More information can be found here: http://www.7-zip.org/
; ---------------------------------

#pragma compile(FileDescription, Link parser and file downloader)
#pragma compile(ProductName, DIDownloader)
#pragma compile(ProductVersion, 0.3.0)
#pragma compile(FileVersion, 0.3.0.0)
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

; Include scripts from other folders
#include "GUI/didGUI.au3"
#include "scripts/updater.au3"
#include "scripts/converter.au3"
#include "scripts/downloader.au3"
#include "scripts/extracter.au3"

Global $latestLink = "https://github.com/lmessenger/DIDownloader/raw/master/DIDownloader.exe"
Global $download = @UserProfileDir & '\Downloads\Drivers'
Global $tbLink
Global $fileLink
Global $fileName
Global $validLink = False

;_checkFileVersion()
_createGUI()
