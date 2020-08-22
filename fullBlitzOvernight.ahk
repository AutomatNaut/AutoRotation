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

; Edit this to whatever path is applicable
MacroFolderPath = C:\macro

LogFileName = %MacroFolderPath%\logs\FullBlitzOvernight.%A_YYYY%%A_MM%%A_DD%.log

logMessage("Starting Full Blitz Overnight...")

TotalTeams = 28
TargetBlitzTier = 2
MyErrorCount = 0
ReportedErrorCount = 0
LossTally := ""

randomSleep(2000, 3000)

FullStartTime := A_TickCount

logMessage("Start Overnight Loop (4)")
Loop, 4
{
	doFullBlitzRotation(TargetBlitzTier, TotalTeams)

	MyErrorCount = 0
	ReportedErrorCount = 0
	LossTally := ""

	if(A_Index < 4)
	{
		logMessage("Wait for next full loop.")
		; Wait 1hr 22 min to 1 hr 55Min
    	randomSleep(4920000, 6920000)
    }
}
logMessage("End fullOvernight")

FullElapsedTime := A_TickCount - FullStartTime

emailSubject := "Blitz Overnight Complete at " A_Hour ":" A_Min ":" A_Sec
emailbody := "Duration: " Round(FullElapsedTime/60000, 2) " min"

randomSleep(10000, 15000)

; sendEmailNotification(emailSubject, emailbody, , )

ExitApp

#Include functions.ahk