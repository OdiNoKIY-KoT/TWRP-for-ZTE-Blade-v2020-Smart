#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/zte/P963F05

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a15

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sp9863a_1h10
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 320

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := console=ttyS1,115200n8 buildvariant=user
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x05400000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_CONFIG := P963F05_defconfig
TARGET_KERNEL_SOURCE := kernel/zte/P963F05

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_BOOTIMG := 
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := 
endif

# Partitions (verified from device GPT 2026-11-20: boot=0x2300000, recovery=0x2800000, super=0xEF000000)
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 36700160
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 41943040
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 4009754624
BOARD_SUPER_PARTITION_GROUPS := zte_dynamic_partitions
BOARD_ZTE_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_ZTE_DYNAMIC_PARTITIONS_SIZE := 4005560320

# Platform
TARGET_BOARD_PLATFORM := sp9863a

# Recovery-as-boot: TWRP lives in the boot partition (C11/Narzo50i method).
# ZTE u-boot verifies recovery strictly but accepts any RSA4096 key for boot
# when unlocked (proven with Magisk). Flash TWRP boot via spd_dump/fastboot,
# restore Magisk boot afterwards.
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
TW_MAX_BRIGHTNESS := 4000
TW_DEFAULT_BRIGHTNESS := 1500
TW_BRIGHTNESS_PATH := "/sys/class/backlight/sprd_backlight/brightness"
TW_INCLUDE_FASTBOOTD := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXCLUDE_TWRPAPP := true
TW_NO_LEGACY_PROPS := true
TW_OVERRIDE_SYSTEM_PROPS := "ro.build.version.sdk"
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true

# Build hacks for prebuilt-heavy tree (from working C11 tree)
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
BUILD_BROKEN_PREBUILT_ELF_FILES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
RELAX_USES_LIBRARY_CHECK := true

# Crypto: userdata is f2fs with encryptable=footer (legacy FDE, not metadata encryption)
# NOTE: twrp-12.1 dropped FDE support (libopenaes gone) - build without crypto first;
# data will be unmountable but all raw-partition backup/flash/fastbootd works.
TW_INCLUDE_CRYPTO := false
TW_INCLUDE_CRYPTO_FBE := false
TW_INCLUDE_FBE := false
PLATFORM_VERSION := 10
PLATFORM_SECURITY_PATCH := 2021-11-05
VENDOR_SECURITY_PATCH := 2021-11-05

# Verified Boot: boot partition accepts any RSA4096 key when unlocked,
# rollback_index must be >= 1 (RPMB img_ver=1). Boot chain location=1.
# Footer re-signed post-build with resign.py --partition boot anyway.
BOARD_AVB_ENABLE := true
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 1

# TWRP Configuration
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := false
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_DEVICE_VERSION := P963F05-by-OdiNoKIY-KoT
TW_NO_SCREEN_TIMEOUT := true
TW_EXCLUDE_TZDATA := true
TW_EXCLUDE_NANO := true
TW_EXCLUDE_BASH := true
TW_EXCLUDE_PYTHON := true
TW_INCLUDE_NTFS_3G := false
TW_INCLUDE_REPACKTOOLS := true
TW_HAS_DOWNLOAD_MODE := false
TW_NO_REBOOT_BOOTLOADER := false

# Size: boot partition only 35MB - strip everything non-essential
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_APEX := true
TW_EXCLUDE_MTP := true
TW_NO_EXFAT := true
TW_NO_EXFAT_FUSE := true
# TW_EXCLUDE_ENCRYPTED_BACKUPS must stay EMPTY: TWRP Android.mk ifneq logic adds libopenaes when set!
TW_NO_HAPTICS := true
TW_NO_USB_STORAGE := true
TW_INCLUDE_JPEG := false
TW_INCLUDE_PNG := false
TWRP_INCLUDE_LOGCAT := false
TARGET_USES_LOGD := false
TW_USE_MINUI_WITH_MEDIA := false
TW_USE_MINUI_WITH_FONTS := false
BOARD_HAS_NO_REAL_SDCARD := true
