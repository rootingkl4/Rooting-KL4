@echo off
:: ============================================================================
::  TECNO SPARK GO 1 (KL4) - RESTORE BLOATWARE
::  Restores all apps removed by debloat.bat
::  Made by dovi & opencode | September 2026
:: ============================================================================

echo.
echo  ========================================================
echo   KL4 RESTORE BLOATWARE
echo   Re-installing removed apps
echo  ========================================================
echo.

adb devices | findstr /r "device$" >nul
if %errorlevel% neq 0 (
    echo [ERROR] No ADB device found!
    pause
    exit /b 1
)

echo [OK] Phone connected! Restoring apps...
echo.

:: Restore all Tecno/Transsion apps
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
 tech.palm.id ^
 com.facebook.appmanager ^
 com.facebook.services ^
 com.facebook.system ^
 com.facebook.katana ^
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

for %%p in (%PACKAGES%) do (
    echo   Restoring: %%p
    adb shell cmd package install-existing %%p 2>nul
)

echo.
echo ========================================================
echo  ALL APPS RESTORED!
echo ========================================================
echo.
pause
