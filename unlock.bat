@echo off
setlocal enabledelayedexpansion

:: ============================================================================
::  TECNO SPARK GO 1 (KL4) - BOOTLOADER UNLOCK & ROOT SCRIPT
::  CVE-2022-38694 Exploit | V4445 | UMS9230E
::  Made by dovi & opencode | September 2026
:: ============================================================================
::
::  DISCLAIMER: This will VOID your warranty and FACTORY RESET your phone.
::  Backup everything before proceeding!
::
::  KL4 AND KL4s ARE DIFFERENT DEVICES. This is for KL4 ONLY.
::
::  FILES NEEDED (all included in this package):
::    unlock/spd_dump.exe
::    unlock/fdl1-dl.bin
::    unlock/fdl2-dl.bin
::    unlock/fdl2-cboot.bin
::    unlock/custom_exec_no_verify_65015f08.bin
::    unlock/gen_spl-unlock.exe
::    unlock/spl-unlock.bin  (pre-patched for V4445)
::    unlock/misc-wipe.bin
::    unlock/u-boot-spl-16k-sign.bin  (V4445 splloader)
::    root/boot.img  (V4445 stock boot)
::    root/Magisk-v30.7.apk
::    root/vbmeta-sign.img
::    platform-tools/adb.exe + fastboot.exe
:: ============================================================================

echo.
echo  ========================================================
echo   TECNO SPARK GO 1 (KL4) - UNLOCK ^& ROOT TOOL
echo   Firmware: V4445 | Chipset: UMS9230E (Unisoc T615)
echo   CVE-2022-38694 Exploit
echo   Made by dovi & opencode | September 2026
echo  ========================================================
echo.
echo  WHAT THIS SCRIPT DOES:
echo    Phase 1: Unlock bootloader via BROM exploit
echo    Phase 2: Restore original files
echo    Phase 3: Flash Magisk-patched boot for root
echo.
echo  EVERYTHING IS INCLUDED. No extra downloads needed!
echo.
echo  BROM MODE: Hold BOTH volume buttons, then plug in USB.
echo             Do NOT hold power button for BROM.
echo.
echo  ========================================================
echo.

set /p CONFIRM="Type YES to start (anything else exits): "
if /i not "%CONFIRM%"=="YES" (
    echo Aborted.
    exit /b 1
)

:: ============================================================================
::  CHECK REQUIRED FILES
:: ============================================================================

echo.
echo [CHECK] Verifying all files are present...

set MISSING=0
for %%f in (spd_dump.exe fdl1-dl.bin fdl2-dl.bin fdl2-cboot.bin custom_exec_no_verify_65015f08.bin gen_spl-unlock.exe spl-unlock.bin misc-wipe.bin u-boot-spl-16k-sign.bin) do (
    if not exist "unlock\%%f" (
        echo   MISSING: unlock\%%f
        set MISSING=1
    ) else (
        echo   OK: unlock\%%f
    )
)

if not exist "root\boot.img" (
    echo   MISSING: root\boot.img
    set MISSING=1
) else (
    echo   OK: root\boot.img
)

if not exist "root\Magisk-v30.7.apk" (
    echo   MISSING: root\Magisk-v30.7.apk
    set MISSING=1
) else (
    echo   OK: root\Magisk-v30.7.apk
)

if %MISSING%==1 (
    echo.
    echo [ERROR] Required files missing!
    pause
    exit /b 1
)

echo.
echo [OK] All files present! Everything is included.
echo.

:: ============================================================================
::  PHASE 1: UNLOCK BOOTLOADER
::  We use the pre-patched spl-unlock.bin (V4445)
::  and fdl2-cboot for the unlock exploit.
:: ============================================================================

echo ========================================================
echo  PHASE 1A: ERASE SPLLOADER
echo ========================================================
echo.
echo  Phone will NOT boot after this - that's normal!
echo.
echo  INSTRUCTIONS:
echo   1. Power off phone completely (hold power 30 sec)
echo   2. Hold BOTH volume up + volume down
echo   3. While holding, plug in USB
echo   4. Release buttons when tool connects
echo.

pause

pushd unlock
spd_dump --wait 300 exec_addr 0x65015f08 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec e splloader e splloader_bak reset
popd

echo.
echo [OK] Splloader erased. Phone will not boot now.
echo.

echo ========================================================
echo  PHASE 1B: WRITE FDL2-CBOOT
echo ========================================================
echo.
echo  INSTRUCTIONS:
echo   1. Hold BOTH volume buttons + plug USB in
echo   2. Wait for tool to connect and write
echo   3. Phone will reset
echo.

pause

pushd unlock
spd_dump --wait 300 exec_addr 0x65015f08 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec w uboot fdl2-cboot.bin reset
popd

echo.
echo [OK] fdl2-cboot written. Phone is resetting.
echo.

echo ========================================================
echo  PHASE 1C: RUN EXPLOIT (THE MAGIC MOMENT!)
echo ========================================================
echo.
echo  Wait 10 seconds, then put phone in BROM mode again.
echo  The patched splloader will be sent via FDL1.
echo  Phone should disconnect - that means it worked!
echo.

echo Waiting 10 seconds...
timeout /t 10 /nobreak >nul

pushd unlock
spd_dump exec_addr 0x65015f08 fdl spl-unlock.bin 0x65000800
popd

echo.
echo [INFO] Exploit sent. Device may have disconnected - this is normal.
echo.

echo ========================================================
echo  VERIFY UNLOCK STATUS
echo ========================================================
echo.
echo  Put phone in BROM mode to check miscdata.
echo  Non-zero data in miscdata = UNLOCKED.
echo.

pause

pushd unlock
spd_dump --wait 300 exec_addr 0x65015f08 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec verbose 2 read_part miscdata 8192 64 m.bin reset
popd

echo.
echo [INFO] Checking m.bin...
certutil -f -hex unlock\m.bin 2>nul
echo.
echo   If all zeros = STILL LOCKED (go back to Phase 1C)
echo   If non-zero data = UNLOCKED (continue below)
echo.
set /p UNLOCKED="Did it unlock? (YES/NO): "
if /i not "%UNLOCKED%"=="YES" (
    echo [INFO] Not unlocked yet. Repeat Phase 1C (the exploit may need twice).
    pause
    exit /b 1
)

:: ============================================================================
::  PHASE 2: RESTORE + FACTORY RESET
:: ============================================================================

echo ========================================================
echo  PHASE 2: RESTORE - Putting phone back together
echo ========================================================
echo.
echo  Put phone in BROM mode.
echo  Phone will factory reset and boot.
echo  You should see "LOCK FLAG IS: UNLOCKED" on boot!
echo.

pause

pushd unlock
spd_dump --wait 300 exec_addr 0x65015f08 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec w splloader u-boot-spl-16k-sign.bin w misc misc-wipe.bin reset
popd

echo.
echo ========================================================
echo  UNLOCK COMPLETE!
echo ========================================================
echo.
echo  Phone will factory reset and boot up.
echo  Look for: "LOCK FLAG IS: UNLOCKED"
echo.
echo  NEXT: Run root.bat after phone boots, USB debugging is ON,
echo        and you are connected to WiFi.
echo.

pause
