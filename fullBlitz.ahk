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

LogFileName = %MacroFolderPath%\logs\FullBlitz.%A_YYYY%%A_MM%%A_DD%.log

logMessage("Starting fullBlitz...")

randomSleep(2000, 3000)

TotalTeams = 28
TargetBlitzTier = 2
MyErrorCount = 0
ReportedErrorCount = 0
LossTally := ""

doFullBlitzRotation(TargetBlitzTier, TotalTeams)

ExitApp

#Include functions.ahk