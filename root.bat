@echo off
setlocal enabledelayedexpansion

:: ============================================================================
::  TECNO SPARK GO 1 (KL4) - ROOT WITH MAGISK
::  Run this AFTER unlock.bat completes successfully
::  Made by dovi & opencode | September 2026
:: ============================================================================

echo.
echo  ========================================================
echo   KL4 ROOT - Magisk Installation
echo  ========================================================
echo.
echo  PREREQUISITES:
echo    - Bootloader must be UNLOCKED (run unlock.bat first)
echo    - Phone booted and set up
echo    - USB Debugging enabled
echo    - Phone connected via USB
echo.
echo  FILES (all included):
echo    root/boot.img          - V4445 stock boot image
echo    root/Magisk-v30.7.apk  - Magisk installer
echo    root/vbmeta-sign.img   - VBMeta (verification disabled)
echo    platform-tools/        - ADB + Fastboot
echo.
echo  ========================================================
echo.

:: ============================================================================
::  CHECK PHONE CONNECTION
:: ============================================================================

echo [CHECK] Looking for phone...

set PATH=%~dp0platform-tools;%PATH%

adb devices | findstr /r "device$" >nul
if %errorlevel% neq 0 (
    echo [ERROR] No ADB device found!
    echo         1. Connect phone via USB
    echo         2. Enable USB Debugging in Developer Options
    echo         3. Accept the USB debugging popup on phone
    pause
    exit /b 1
)

echo [OK] Phone connected!
echo.

:: ============================================================================
::  PUSH FILES TO PHONE
:: ============================================================================

echo ========================================================
echo  STEP 1: Pushing files to phone
echo ========================================================
echo.

echo [PUSH] Magisk APK...
adb push "%~dp0root\Magisk-v30.7.apk" /sdcard/Download/

echo [PUSH] Stock boot.img...
adb push "%~dp0root\boot.img" /sdcard/Download/

echo.
echo [OK] Files pushed to phone.
echo.

:: ============================================================================
::  INSTALL MAGISK
:: ============================================================================

echo ========================================================
echo  STEP 2: Installing Magisk APK
echo ========================================================
echo.

adb install "%~dp0root\Magisk-v30.7.apk"

echo.
echo [OK] Magisk installed on phone.
echo.

:: ============================================================================
::  INSTRUCT USER TO PATCH
:: ============================================================================

echo ========================================================
echo  STEP 3: Patch boot.img with Magisk
echo ========================================================
echo.
echo  ON YOUR PHONE:
echo   1. Open the Magisk app
echo   2. Tap "Install" (next to Magisk version)
echo   3. Tap "Select and Patch a File"
echo   4. Go to Download folder
echo   5. Select "boot.img" (the 64MB file)
echo   6. Wait for "All done!"
echo.
echo  The patched file will be saved as magisk_patched-XXXXX.img
echo  in the Download folder.
echo.

pause

:: ============================================================================
::  PULL PATCHED FILE
:: ============================================================================

echo ========================================================
echo  STEP 4: Pulling patched boot back to PC
echo ========================================================
echo.

for /f "delims=" %%i in ('adb shell ls /sdcard/Download/magisk_patched-*.img 2^>nul') do (
    set PATCHED_FILE=%%i
    goto :found
)

echo [ERROR] No magisk_patched file found on phone!
echo         Make sure you patched boot.img in Magisk.
pause
exit /b 1

:found
echo [INFO] Found patched file: %PATCHED_FILE%
adb pull %PATCHED_FILE% "%~dp0root\magisk_boot.img"
echo.
echo [OK] Patched boot pulled to root\magisk_boot.img
echo.

:: ============================================================================
::  FLASH PATCHED BOOT
:: ============================================================================

echo ========================================================
echo  STEP 5: Flash Magisk-patched boot
echo ========================================================
echo.
echo  Phone will reboot to fastboot mode automatically.
echo  NOTE: Fastboot may disconnect briefly after each flash.
echo        Just wait a few seconds and it'll reconnect.
echo.

adb reboot bootloader

echo Waiting for fastboot...
timeout /t 8 /nobreak >nul

echo.
echo [FLASH] Flashing to boot_a...
fastboot flash boot_a "%~dp0root\magisk_boot.img"
echo.

echo [FLASH] Flashing to boot_b...
fastboot flash boot_b "%~dp0root\magisk_boot.img"
echo.

echo [REBOOT] Rebooting phone...
fastboot reboot
echo.

:: ============================================================================
::  VERIFY ROOT
:: ============================================================================

echo ========================================================
echo  STEP 6: Verify root
echo ========================================================
echo.
echo  After phone boots:
echo   1. Open Magisk app
echo   2. Should show "Installed: 30.7" (not "N/A")
echo   3. Superuser tab should be available
echo.
echo  ========================================================
echo   ROOT COMPLETE!
echo   Your KL4 is now bootloader unlocked + rooted.
echo   Made with love by dovi & opencode | September 2026
echo   Share freely, no gatekeeping!
echo  ========================================================
echo.

pause
