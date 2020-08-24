; ********** Functions **************

randomSleep(min, max)
{
    Random, randomValue, min, max
    
    if(randomValue > 3600000)
	{
	    msg := "Sleeping for " Round(randomValue/3600000, 2) " hours"
    }
    else if(randomValue > 60000)
    {
    	msg := "Sleeping for " Round(randomValue/60000, 2) " minutes"
    }
    else if(randomValue > 1000)
    {
    	msg := "Sleeping for " Round(randomValue/1000, 2) " seconds"
    }
    else
    {
    	msg = Sleeping for %randomValue% ms
    }
    
    logMessage(msg)
    
    Sleep, %randomValue%
}

activateBluestacks()
{
	WinActivate, BlueStacks
	randomSleep(343, 684)
	; 1983
	WinMove BlueStacks, , 83, 52, 1633, 926
}

logMessage(logMsg)
{
	global LogFileName 
	
	CurrentDate := A_YYYY "-" A_MM "-" A_DD
	CurrentTime := A_Hour ":" A_Min ":" A_Sec "." A_MSec
	
	FileAppend, %CurrentDate% %CurrentTime%: %logMsg%`n, %LogFileName%
}

findOpponent(minOpp, maxOpp)
{
	Random, timesToSearch, minOpp, maxOpp
	msg := "Finding " timesToSearch " Opponents"
	logMessage(msg)
	Loop, %timesToSearch%
	{
		pressKey("q")
    	randomSleep(1488, 2231)
	}
}

isBlitzCoresOrCredits()
{
	activateBluestacks()
	
	PixelGetColor, ColorFound, 843, 691
	msg := "Pixel Get Color Results (Cores or Credits): " ColorFound
	logMessage(msg)

	if(ColorFound = 0xFFFFFF)
	{
		return true
	}
	
	return false
}

isBlitzTier(tierNum)
{
	activateBluestacks()
	
	PixelGetColor, T1ColorFound, 624, 152
	msg := "Pixel Get Color Results (Tier 1): " T1ColorFound
	logMessage(msg)
	
	PixelGetColor, T2ColorFound, 622, 162
	msg := "Pixel Get Color Results (Tier 2): " T2ColorFound
	logMessage(msg)
	
	PixelGetColor, T3ColorFound, 629, 162
	msg := "Pixel Get Color Results (Tier 3): " T3ColorFound
	logMessage(msg)
	
	if(tierNum = 1 and T1ColorFound = 0xFBD7D4)
	{
		return true
	}
	else if(tierNum = 2 and T2ColorFound = 0xFBD7D4 and T1ColorFound != 0xFBD7D4)
	{
		return true
	}
	else if(tierNum = 3 and T3ColorFound = 0xFBD7D4)
	{
		return true
	}	
	
	return false
}

set3TimesSpeed()
{
	Loop, 3
	{
		activateBluestacks()
		
		PixelGetColor, ColorFound, 77,302
		msg := "Pixel Get Color Results (3 Speed): " ColorFound
		logMessage(msg)
		
		if(ColorFound = 0xFFFFFF)
		{
			break
		}

		pressKey("d")
		
		randomSleep(1011, 2025)
	}
}

isWin()
{
	activateBluestacks()
	
	PixelGetColor, ColorFound, 936, 127
	msg := "Pixel Get Color Results (Is Win): " ColorFound
	logMessage(msg)

	if(ColorFound = 0xFFFFFF)
	{
		return true
	}
	
	return false
}

isMatchDone()
{
	TimesLooped = 0

	Loop
	{
		activateBluestacks()
		
		PixelGetColor, ColorFound, 658, 821
		msg := "Pixel Get Color Results (Continue): " ColorFound
		logMessage(msg)
		
		if(ColorFound = 0xFFFFFF)
		{
			break
		}
		else if (TimesLooped > 27)
		{
			logMessage("isMatchDone looped too many times")
			
			global MyErrorCount
			MyErrorCount++
			
			resizeWindow()
			
			break
		}
		else
		{
    		randomSleep(5195, 7621)
    	}
    	
    	TimesLooped++
	}
}

isBattleReady()
{
	BattleTimesLooped = 0

	Loop
	{
		activateBluestacks()
		
		PixelGetColor, ColorFound, 742, 727
		msg := "Pixel Get Color Results (Battle Ready): " ColorFound
		logMessage(msg)
		
		if(ColorFound = 0xFFFFFF)
		{
			break
		}
		
		if(isBlitzCoresOrCredits())
		{
			break
		}
		else if (BattleTimesLooped > 9)
		{
			logMessage("isBattleReady looped too many times")
			
			global MyErrorCount
			MyErrorCount++
			
			resizeWindow()
			
			break
		}
		else
		{
    		randomSleep(1729, 3472)
    	}
    	
    	BattleTimesLooped++
	}
}

isThreeSpeedReady()
{
	SpeedTimesLooped = 0

	Loop
	{
		activateBluestacks()
	
		PixelGetColor, TSColorFound, 73,294
		msg := "Pixel Get Color Results (3 Speed): " TSColorFound
		logMessage(msg)
		
		if(TSColorFound = 0xFFFFFF)
		{
			break
		}
		else if (SpeedTimesLooped > 20)
		{
			logMessage("isThreeSpeedReady looped too many times")
			
			global MyErrorCount
			MyErrorCount++
			
			resizeWindow()
			
			break
		}
		else
		{
    		randomSleep(1729, 3472)
    	}
    	
    	SpeedTimesLooped++
	}
}

isRewardsVisible()
{
	RewardsTimesLooped = 0

	Loop
	{
		activateBluestacks()
	
		PixelGetColor, RColorFound, 1271, 183
		msg := "Pixel Get Color Results (Rewards): " RColorFound
		logMessage(msg)
		
		if(RColorFound = 0xFFFFFF)
		{
			break
		}
		else if (RewardsTimesLooped > 15)
		{
			logMessage("isRewardsVisible looped too many times")
			
			global MyErrorCount
			MyErrorCount++
			
			resizeWindow()
			
			break
		}
		else
		{
    		randomSleep(3729, 5472)
    	}
    	
    	RewardsTimesLooped++
	}
}

sendEmailNotification(Subject, Body, Attachment1:="", Attachment2:="")
{
	global MacroFolderPath
	
	msg := "Sending Email Notification..." Subject " --- " Body " --- " Attachment1 " " Attachment2
	
	logMessage(msg)
	
	if(Attachment1 = "" and Attachment2 = "")
	{
		Run, powershell -File %MacroFolderPath%\SendEmailNotification.ps1 --Subject "%Subject%" --Body "%Body%"
	}
	else
	{
		Run, powershell -File %MacroFolderPath%\SendEmailNotification.ps1 --Subject "%Subject%" --Body "%Body%" --Attachment1 %Attachment1% --Attachment2 %Attachment2%
	}
}

TakeScreenshot(FileName)
; beaucoup thanks to tic (Tariq Porter) for his GDI+ Library
; https://autohotkey.com/boards/viewtopic.php?t=6517
; https://github.com/tariqporter/Gdip/raw/master/Gdip.ahk
{
  activateBluestacks()

  pToken:=Gdip_Startup()
  If (pToken=0)
  {
    MsgBox,4112,Fatal Error,Unable to start GDIP
    ExitApp
  }
  pBitmap:=Gdip_BitmapFromScreen(1)
  If (pBitmap<=0)
  {
    MsgBox,4112,Fatal Error,pBitmap=%pBitmap% trying to get bitmap from the screen
    ExitApp
  }
  Gdip_SaveBitmapToFile(pBitmap,FileName)
  If (ErrorLevel<>0)
  {
    MsgBox,4112,Fatal Error,ErrorLevel=%ErrorLevel% trying to save bitmap to`n%FileName%
    ExitApp
  }
  Return
}

; change the line below to wherever you have the downloaded GDIP source code
#Include Gdip_All.ahk

pressKey(key)
{
	msg := "Pressing Key: " key
	logMessage(msg)
	activateBluestacks()
	SendRaw, %key%
}

checkForErrors()
{
	global MyErrorCount
	global ReportedErrorCount

	if(MyErrorCount > 0 and (MyErrorCount > ReportedErrorCount))
	{
		ReportedErrorCount = %MyErrorCount%
		
		emailSubject := "Blitz Error Occurred"
		emailbody := MyErrorCount " Errors occurred"
		
		sendEmailNotification(emailSubject, emailbody)
	}
}

resizeWindow()
{
	activateBluestacks()
	
	randomSleep(2319, 3122)
	MouseClickDrag, L, 1631, 300, 1250, 300
	randomSleep(2319, 3122)
	MouseClickDrag, L, 1250, 300, 1631, 300
	randomSleep(2319, 3122)
	MouseClick, left, 1600, 20
	randomSleep(2319, 3122)
	MouseClick, left, 1541, 20
}

doFullBlitzRotation(TargetBlitzTier, TotalTeams)
{
	TeamsUsed = 0

	CurrentDate := A_YYYY "-" A_MM "-" A_DD
	CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec

	global MacroFolderPath

	startFileName := MacroFolderPath "\logs\BlitzStart_Tier" TargetBlitzTier "_" CurrentDate "_" CurrentTime ".png"

	TakeScreenshot(startFileName)

	StartTime := A_TickCount

	logMessage("Start Loss Loop")
	Loop, 7
	{
		if(isBlitzTier(TargetBlitzTier))
		{
			logMessage("Reached target Blitz Tier, starting wins now")
			break	
		}

		findOpponent(1, 1)
		randomSleep(1924, 3606)

		isBattleReady()

		; Battle
		if(isBlitzCoresOrCredits())
		{
			randomSleep(2176, 4349)
			logMessage("Battle was cores or credits, next team")
			Goto, NextLoseTeam
		}
		else
		{
			pressKey("w")
		}

		randomSleep(26135, 29248)

		isThreeSpeedReady()

		set3TimesSpeed()

		; Options
		pressKey("a")
		randomSleep(2204, 4001)

		; Quit Battle
		pressKey("s")
		randomSleep(3378, 5105)

		; Lose Battle
		pressKey("s")

		isMatchDone()

		randomSleep(2319, 4922)

		; Continue
		if(isBlitzCoresOrCredits())
		{
			randomSleep(2176, 4349)
			logMessage("Battle was cores or credits, next team")
			Goto, NextLoseTeam
		}
		else
		{
			pressKey("w")
		}

		randomSleep(4306, 5482)

		; isChangeTeamReady()
		isRewardsVisible()

		randomSleep(1306, 3482)
		; Next Team
		NextLoseTeam:
		pressKey("r")
		randomSleep(5304, 9196)

		TeamsUsed++
		
		checkForErrors()
	}

	msg := "Starting Win loop Win Teams Left " TotalTeams - TeamsUsed
	logMessage(msg)

	Wins = 0
	Losses = 0

	Loop % TotalTeams - TeamsUsed
	{
		findOpponent(1, 1)
		randomSleep(3624, 6606)

		isBattleReady()

		; Battle
		if(isBlitzCoresOrCredits())
		{
			randomSleep(2176, 4349)
			logMessage("Battle was cores or credits, next team")
			Goto, NextTeam
		}
		else
		{
			findOpponent(0, 5)
			isBattleReady()
			pressKey("w")
		}

		isThreeSpeedReady()

		; Auto
		pressKey("e")
		
		; In case get stuck on loss screen
		randomSleep(2319, 4222)
		pressKey("s")

		isMatchDone()
		randomSleep(2319, 4222)

		; Continue
		if(isWin())
		{
			Wins++
		}
		else
		{
			Losses++
			msg := "Lost at " A_Index
			logMessage(msg)
			
			global LossTally
			LossTally = %LossTally% %A_Index%, 
		}

		if(isBlitzCoresOrCredits())
		{
			randomSleep(2176, 4349)
			logMessage("Battle was cores or credits, next team")
			Goto, NextTeam
		}
		else
		{
			pressKey("w")
		}

		; isChangeTeamReady()
		isRewardsVisible()

		randomSleep(2123, 3489)

		; Next Team
		NextTeam:
		pressKey("r")
		randomSleep(3105, 5612)
		
		checkForErrors()
	}
	logMessage("Ending fullBlitz.")
	winLossMsg := "Record W:" Wins " L:" Losses
	logMessage(winLossMsg)

	ElapsedTime := A_TickCount - StartTime

	CurrentDate := A_YYYY "-" A_MM "-" A_DD
	CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec

	global MacroFolderPath
	endFileName := MacroFolderPath "\logs\BlitzEnd_Tier" TargetBlitzTier "_W" Wins "_L" Losses "_" CurrentDate "_" CurrentTime ".png"

	TakeScreenshot(endFileName)
	
	emailSubject := "Blitz Tier " TargetBlitzTier " Complete at " A_Hour ":" A_Min ":" A_Sec
	global MyErrorCount
	emailbody := "Wins: " Wins ", Losses: " Losses ", Duration: " Round(ElapsedTime/60000, 2) " min, Errors: " MyErrorCount ", Loses at: " LossTally
	
	sendEmailNotification(emailSubject, emailbody, startFileName, endFileName)
}
