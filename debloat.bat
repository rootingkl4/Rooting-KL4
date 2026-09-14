@echo off
:: ============================================================================
::  TECNO SPARK GO 1 (KL4) - DEBLOAT SCRIPT
::  Removes bloatware via ADB (no root required, but root makes it easier)
::  Tested on: V4445 | HiOS | Android 14 Go
::  Made by dovi & opencode | September 2026
:: ============================================================================
::
::  HOW TO USE:
::    1. Connect phone via USB with USB Debugging ON
::    2. Double-click this file
::    3. Apps will be uninstalled for current user
::    4. To restore any app: adb shell cmd package install-existing <package>
::
::  WHAT'S SAFE TO REMOVE:
::    All packages below are confirmed safe by multiple Tecno users
::    on Reddit, GitHub, and XDA forums.
::
::  KL4 AND KL4s ARE DIFFERENT. This is for KL4 only.
:: ============================================================================

echo.
echo  ========================================================
echo   KL4 DEBLOAT SCRIPT
echo   Removing bloatware from Tecno Spark Go 1 (KL4)
echo  ========================================================
echo.
echo  This removes bloatware for your current user only.
echo  Everything can be restored if needed.
echo.
echo  ========================================================
echo.

adb devices | findstr /r "device$" >nul
if %errorlevel% neq 0 (
    echo [ERROR] No ADB device found!
    echo         Connect phone with USB Debugging enabled.
    pause
    exit /b 1
)

echo [OK] Phone connected!
echo.

:: ============================================================================
::  TECNO / TRANSSION BLOATWARE
:: ============================================================================

echo ========================================================
echo  Removing Tecno/Transsion bloatware...
echo ========================================================

set PACKAGES= ^
 com.transsion.phonemanager ^
 com.transsion.phonemaster ^
 com.transsion.carlcare ^
 com.transsion.tecnospot ^
 com.transsion.batterylab ^
 com.transsion.hamal ^
 com.transsion.statisticalsales ^
 com.transsion.trancare ^
 com.transsion.childmode ^
 com.transsion.childmode.resoverlay ^
 com.transsion.notebook ^
 com.transsion.compass ^
 com.transsion.magicshow ^
 com.transsion.fmradio ^
 com.transsion.letswitch ^
 com.transsion.aivoiceassistant ^
 com.transsion.smartpanel ^
 com.transsion.theme.icon ^
 com.transsion.plat.appupdate ^
 com.transsion.scanningrecharger ^
 com.transsion.audioshare ^
 com.transsion.datatransfer ^
 com.transsion.manualguide ^
 com.transsion.agingfunction ^
 com.transsion.tranengine ^
 com.transsion.nephilim ^
 com.transsion.ella ^
 com.transsion.tabe ^
 com.transsion.succ ^
 com.transsion.teop ^
 com.transsion.repaircard ^
 com.transsion.ossettingsext ^
 com.transsion.screenrecorder ^
 com.transsion.aisettings ^
 com.transsion.uxdetector ^
 com.transsion.deskclock ^
 com.transsion.autotest.factory ^
 com.transsion.overlaysuw ^
 com.transsion.microintelligence ^
 com.transsion.dynamicbar ^
 com.transsion.dynamicbar.overlay ^
 com.transsion.overlaysuw.resoverlay ^
 com.transsion.resolver ^
 com.transsion.faceid ^
 com.transsion.guideservice ^
 com.transsion.tranfacmode ^
 com.transsion.thub.res ^
 com.transsion.dtsaudio ^
 com.transsion.systemupdate ^
 com.rlk.weathers ^
 com.funbase.xradio ^
 com.zaz.translate ^
 com.talpa.hibrowser ^
 tech.palm.id

for %%p in (%PACKAGES%) do (
    echo   Removing: %%p
    adb shell pm uninstall --user 0 %%p 2>nul
)
echo.

:: ============================================================================
::  FACEBOOK BLOATWARE
:: ============================================================================

echo ========================================================
echo  Removing Facebook bloatware...
echo ========================================================

set FACEBOOK= ^
 com.facebook.appmanager ^
 com.facebook.services ^
 com.facebook.system ^
 com.facebook.katana

for %%p in (%FACEBOOK%) do (
    echo   Removing: %%p
    adb shell pm uninstall --user 0 %%p 2>nul
)
echo.

:: ============================================================================
::  GOOGLE BLOATWARE (OPTIONAL - comment out lines you want to keep)
:: ============================================================================

echo ========================================================
echo  Removing Google bloatware...
echo ========================================================
echo  (Comment out any you want to keep in the script)
echo.

set GOOGLE= ^
 com.google.android.apps.youtube.music ^
 com.google.android.apps.wellbeing ^
 com.google.android.apps.nbu.files ^
 com.google.android.apps.restore ^
 com.google.android.apps.safetyhub ^
 com.google.android.apps.assistant ^
 com.google.android.tts ^
 com.google.android.marvin.talkback ^
 com.google.android.videos ^
 com.google.android.googlequicksearchbox ^
 com.google.android.gm ^
 com.google.android.apps.tachyon

for %%p in (%GOOGLE%) do (
    echo   Removing: %%p
    adb shell pm uninstall --user 0 %%p 2>nul
)
echo.

:: ============================================================================
::  DONE
:: ============================================================================

echo ========================================================
echo  DEBLOAT COMPLETE!
echo ========================================================
echo.
echo  Apps removed for current user only.
echo  To restore any app:
echo    adb shell cmd package install-existing ^<package.name^>
echo.
echo  TO REVERT EVERYTHING (restore all bloatware):
echo    Run restore_bloat.bat
echo.
echo  ========================================================
echo   Made with love by dovi & opencode | September 2026
echo  ========================================================
echo.

pause
