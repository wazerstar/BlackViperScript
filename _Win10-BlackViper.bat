@ECHO OFF
:: Instructions
:: Bat, Script MUST be in same Folder
:: Change Option to = one of the listed options (mostly yes or no)

Set Black_Viper=0
:: 0 = Run with Menu
:: 1 = Run with Windows Default Service Configuration
:: 2 = Run with Black Viper Safe
:: 3 = Run with Black Viper Tweaked

:: Change these to yes or no
Set Accept_ToS=no
:: no = See ToS
:: yes = Skip ToS (You accepted it)

Set Automated=yes 
:: no = Pause on - User input, On Errors, or End of Script
:: yes = Close on - User input, On Errors, or End of Script
:: yes, Implies that you accept the "ToS"
								
:: Update Checks   
:: If update is found it will Auto-download and use that (with your settings)       
Set Script=no
Set Service=no
Set Internet_Check=yes 
:: Internet_Check only matters If Script or Service is yes and pings to github.com is blocked

:: Skip Script Check
:: SKIP AT YOUR OWN RISK
Set Skip_Build_Check=no
Set Skip_Edition_Check=no

:: Diagnostic Output (Wont run script)
Set Diag=no

::----------------------------------------------------------------------
:: Do not change unless you know what you are doing
Set Script_File=BlackViper-Win10.ps1
Set Script_Directory=%~dp0
Set Script_Path=%Script_Directory%%Script_File%

:: DO NOT CHANGE ANYTHING PAST THIS LINE
::----------------------------------------------------------------------
if /i not "%*"=="" (
    for %%i in (%*) do (
  	    if /i %%i==-atos set Accept_ToS=yes
  	    if /i %%i==-auto set Automated=yes
  	    if /i %%i==-usc set Script=yes
  	    if /i %%i==-use set Service=yes
  	    if /i %%i==-sic set Internet_Check=yes
  	    if /i %%i==-sbc set Skip_Build_Check=yes
  	    if /i %%i==-sec set Skip_Edition_Check=yes
  	    if /i %%i==-default set Black_Viper=1
  	    if /i %%i==-safe set Black_Viper=2
  	    if /i %%i==-tweaked set Black_Viper=3
  	    if /i %%i==-diag set Diag=yes
  	    if /i %%i==-set set SetArg=yes
	
  	    if /i %SetArg%==yes (
	        if /i %%i==default set Black_Viper=1
    	    if /i %%i==safe set Black_Viper=2
	        if /i %%i==tweaked set Black_Viper=3
	        if /i %%i==1 set Black_Viper=1
    	    if /i %%i==2 set Black_Viper=2
	        if /i %%i==3 set Black_Viper=3
		    set SetArg=no
	    )
    )
)

SETLOCAL ENABLEDELAYEDEXPANSION
If %Accept_ToS%==yes Set Run_Option=!Run_Option! -atos

If %Black_Viper%==1 Set Run_Option=!Run_Option! -default
If %Black_Viper%==default Set Run_Option=!Run_Option! -default

If %Black_Viper%==2 Set Run_Option=!Run_Option! -safe
If %Black_Viper%==safe Set Run_Option=!Run_Option! -safe

If %Black_Viper%==3 Set Run_Option=!Run_Option! -tweaked
If %Black_Viper%==tweaked Set Run_Option=!Run_Option! -tweaked

If %Skip_Build_Check%==yes Set Run_Option=!Run_Option! -sbc

If %Skip_Edition_Check%==yes Set Run_Option=!Run_Option! -sec

If %Internet_Check%==no Set Run_Option=!Run_Option! -sic

If %Script%==yes Set Run_Option=!Run_Option! -usc

If %Service%==yes Set Run_Option=!Run_Option! -use

If %Automated%==yes Set Run_Option=!Run_Option! -auto

If %Diag%==yes Set Run_Option=!Run_Option! -diag

echo "Running !Script_File!"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File "!Script_Path! !Run_Option!"' -Verb RunAs}";
ENDLOCAL DISABLEDELAYEDEXPANSION
