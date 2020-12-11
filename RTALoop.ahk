#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
#UseHook
#Persistent

MacroFolderPath = C:\Users\Christopher\Desktop\macro
LogFileName = %MacroFolderPath%\logs\RTALoop.%A_YYYY%%A_MM%%A_DD%.log

logMessage("Starting RTA...")

MyErrorCount = 0
ReportedErrorCount = 0
LossTally := ""

randomSleep(2000, 3000)
; disconnectRemoteDesktop()
; randomSleep(900000, 900000)

FullStartTime := A_TickCount

logMessage("Start RTA")

; changeResolution()

Loop, 4
{
	doRTALoop()

	MyErrorCount = 0
	ReportedErrorCount = 0
	LossTally := ""
}
logMessage("End RTA")

FullElapsedTime := A_TickCount - FullStartTime

emailSubject := "RTA Complete at " A_Hour ":" A_Min ":" A_Sec
emailbody := "Duration: " Round(FullElapsedTime/60000, 2) " min"

randomSleep(10000, 15000)

; sendEmailNotification(emailSubject, emailbody, , )

; changeResolution()

ExitApp

#Include functions.ahk