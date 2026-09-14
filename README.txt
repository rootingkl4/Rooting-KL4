================================================================================
  TECNO SPARK GO 1 (KL4) - COMPLETE ROOT PACKAGE
  Everything included - no extra downloads needed!
  CVE-2022-38694 Exploit | V4445 | UMS9230E
  Made by dovi & opencode | September 2026
================================================================================

IMPORTANT: KL4 AND KL4s ARE DIFFERENT DEVICES! FCC IDs are different.
           Firmware is NOT cross-compatible. This package is for KL4 ONLY.

================================================================================
  WHAT'S IN THIS PACKAGE (everything you need!)
================================================================================

  KL4-Root-Guide/
  |
  |-- unlock.bat              Unlock bootloader (run first)
  |-- root.bat                Root with Magisk (run second)
  |-- debloat.bat             Remove bloatware (optional)
  |-- restore_bloat.bat       Restore removed apps (optional)
  |-- README.txt              This file
  |-- debloat-list.txt        Full list of removable packages
  |
  |-- unlock/                 BROM exploit tools (V4445 specific)
  |   |-- spd_dump.exe                    BROM exploit tool
  |   |-- fdl1-dl.bin                     First stage flasher
  |   |-- fdl2-dl.bin                     Second stage flasher
  |   |-- fdl2-cboot.bin                  Custom boot for unlock
  |   |-- custom_exec_no_verify_65015f08.bin  BROM exploit payload
  |   |-- gen_spl-unlock.exe              SPL patcher
  |   |-- spl-unlock.bin                  Pre-patched V4445 splloader
  |   |-- misc-wipe.bin                   Factory reset trigger
  |   |-- u-boot-spl-16k-sign.bin         Stock V4445 splloader
  |
  |-- root/                   Root files (V4445 specific)
  |   |-- boot.img                        Stock V4445 boot image (64MB)
  |   |-- Magisk-v30.7.apk                Magisk installer (11MB)
  |   |-- vbmeta-sign.img                 Stock VBMeta
  |
  |-- platform-tools/         ADB + Fastboot from Google
      |-- adb.exe
      |-- fastboot.exe
      |-- AdbWinApi.dll
      |-- AdbWinUsbApi.dll

================================================================================
  QUICK START (3 steps!)
================================================================================

  1. Extract this zip to your PC
  2. Double-click "unlock.bat" and follow the prompts
  3. After unlock completes, double-click "root.bat" and follow prompts

  That's it! The scripts guide you through everything.

================================================================================
  BEFORE YOU START - DO THIS FIRST!
================================================================================

  1.1  Enable Developer Options:
       Settings > About Phone > tap "Build Number" 7 times

  1.2  Enable OEM Unlocking:
       Settings > System > Developer Options > OEM Unlocking = ON
       (Phone needs internet - this writes "legal unlock data" to miscdata)
       *** THIS IS CRITICAL - without this, the unlock won't work! ***

  1.3  Enable USB Debugging:
       Settings > System > Developer Options > USB Debugging = ON

  1.4  Install SPD USB Drivers on your PC if not already installed

================================================================================
  STEP-BY-STEP GUIDE
================================================================================

-------------------------------------------------------------------------------
  PHASE 1: UNLOCK BOOTLOADER (unlock.bat)
-------------------------------------------------------------------------------

  The unlock.bat script handles all the BROM exploit steps.
  Just follow the on-screen prompts.

  BROM MODE (how to enter):
    1. Power off phone completely (hold power 30 seconds)
    2. Hold BOTH volume up + volume down
    3. While holding, plug in USB cable
    4. Release buttons when tool connects
    DO NOT hold power button for BROM mode!

  What happens during unlock:
    Phase 1A: Erases splloader (phone won't boot - normal!)
    Phase 1B: Writes fdl2-cboot to uboot (custom unlock payload)
    Phase 1C: Sends patched splloader via FDL1 (the actual unlock)
    Verify:   Reads miscdata to confirm unlock
    Restore:  Restores original splloader + factory reset

  After unlock, you should see on boot screen:
    "LOCK FLAG IS: UNLOCKED"

-------------------------------------------------------------------------------
  PHASE 2: ROOT WITH MAGISK (root.bat)
-------------------------------------------------------------------------------

  After phone boots from factory reset:
    1. Set up phone, enable USB Debugging
    2. Connect USB, run root.bat
    3. Follow prompts - it pushes Magisk + boot.img to phone
    4. You patch boot.img in Magisk app
    5. Script pulls patched file and flashes via fastboot
    6. Phone reboots - open Magisk to verify (should show "Installed: 30.7")

  NOTE: This device uses boot.img (NOT init_boot.img) for Magisk.

-------------------------------------------------------------------------------
  PHASE 3: DEBLOAT (debloat.bat) - OPTIONAL
-------------------------------------------------------------------------------

  Removes ~70 bloatware apps from Tecno/Transsion and Google.
  All apps can be restored with restore_bloat.bat if needed.
  See debloat-list.txt for full list with descriptions.

================================================================================
  TROUBLESHOOTING
================================================================================

  Q: Phone shows "NO VALID OS FOUND"
  A: Splloader is missing. In unlock.bat, restore it:
     spd_dump ... exec w splloader u-boot-spl-16k-sign.bin reset

  Q: Phone stuck on black screen
  A: Hold power for 30 seconds, then try BROM mode again.

  Q: Can't enter BROM mode (shows charging icon)
  A: 1. Unplug USB completely
     2. Hold BOTH volume buttons FIRST
     3. While still holding, THEN plug in USB

  Q: Fastboot keeps disconnecting
  A: Normal on Unisoc! Wait a few seconds and retry.
     The script handles this automatically.

  Q: Magisk shows "N/A" after flashing
  A: Make sure you patched boot.img (64MB), NOT init_boot.img.
     Repeat root.bat.

  Q: Phone bootloops after root
  A: Enter BROM and flash stock boot:
     spd_dump ... exec w boot_b boot.img reset

  Q: Exploit doesn't work (miscdata still all zeros)
  A: Make sure OEM Unlocking is ON in Developer Options!
     The exploit needs the "legal unlock data" from Tecno's server.
     Enable OEM unlock, connect to WiFi, wait 5 minutes, try again.

  Q: "FDL2: incompatible partition"
  A: This is normal! It's a warning, not an error. The exploit still works.

================================================================================
  KEY INFORMATION
================================================================================

  Device:              TECNO Spark Go 1 (KL4)
  Android Version:     14 (Go Edition)
  HiOS Version:        V4445
  Chipset:             Unisoc T615 (UMS9230E)
  BROM exec_addr:      0x65015f08
  FDL1 Address:        0x65000800
  FDL2 Address:        0x9efffe00
  Active Slot:         b (A/B device)
  Boot Chain:          BROM -> splloader -> uboot -> boot -> Android

  KL4 vs KL4s:         DIFFERENT DEVICES - NOT cross-compatible!
  V4445 Exploit:       CVE-2022-38694 works (as of September 2026)
  Root Method:         Magisk 30.7 via patched boot.img
  Partition to patch:  boot.img (NOT init_boot.img for this device)

  NOTE: The FDL files (fdl1-dl.bin, fdl2-dl.bin) in this package
  are specifically for KL4 from 4PDA. Generic UMS9230 FDL files
  may NOT work on this device due to DRAM initialization differences.

================================================================================
  CREDITS & SOURCES
================================================================================

  - TomKing062     - CVE-2022-38694 exploit tool (github.com/TomKing062)
  - 4PDA community - KL4-specific BROM files (custom spd_dump + fdl1/fdl2)
  - @NethWs3Dev    - KL4 XOS port and exploit info (XDA/Telegram)
  - Hovatek        - HiOS debloat guide (hovatek.com)
  - @spectrMeltdown - Tecno debloat script (GitHub Gist)
  - topjohnwu      - Magisk (github.com/topjohnwu/Magisk)
  - bismoy-bot     - PAC-Extractor (github.com/bismoy-bot/PAC-Extractor)

  Exploit tool:  github.com/TomKing062/CVE-2022-38694_unlock_bootloader
  KL4 issue:     github.com/TomKing062/CVE-2022-38694_unlock_bootloader/issues/180
  XDA thread:    xdaforums.com/t/guide-unlock-root-gsi-tecno-spark-go-1-kl4-thread.4736039/

================================================================================
  DISCLAIMER
================================================================================

  This package is for educational purposes. Unlocking your bootloader and
  rooting your device will VOID your warranty. Proceed at your own risk.
  We are not responsible for any bricked devices or lost data.

  Always backup important data before starting this process.
  A factory reset WILL occur during the unlock process.

================================================================================
  Made with love by dovi & opencode | September 2026
  Share freely, no gatekeeping! Peace.
================================================================================
