#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9


# File systems
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296 
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_USES_RECOVERY_AS_BOOT := true

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

TARGET_COPY_OUT_VENDOR := vendor

# Kernel
BOARD_KERNEL_CMDLINE := \
    console=ttyMSM0,115200n8 \
    earlycon=msm_geni_serial,0xa90000 \
    androidboot.hardware=qcom \
    androidboot.console=ttyMSM0 \
    androidboot.memcg=1 \
    lpm_levels.sleep_disabled=1 \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    msm_rtb.filter=0x237 \
    service_locator.enable=1 \
    swiotlb=2048 \
    loop.max_part=7 \
    androidboot.usbcontroller=a600000.dwc3 \
    kpti=off \
    androidboot.selinux=permissive

BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x00000000

BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_KERNEL_IMAGE_NAME := Image.gz
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/msm-4.14/
TARGET_KERNEL_CONFIG := surfaceduo-perf_defconfig

#Prebuilt Kernel and Modules
NEED_KERNEL_MODULE_RECOVERY := true
#TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img

# Platform
TARGET_BOARD_PLATFORM := surfaceduo
TARGET_USES_HARDWARE_QCOM_BOOTCTRL := true

# Recovery
TARGET_OTA_ASSERT_DEVICE := duo
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab

ifeq ($(BUILD_TYPE), twrp)
# TWRP Debug
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TARGET_RECOVERY_DEVICE_MODULES += \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0
#TWRP_EVENT_LOGGING := true

#TWRP Decryption
#PLATFORM_SECURITY_PATCH := 2127-12-31
#VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
#PLATFORM_VERSION := 127
#PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
TW_INCLUDE_CRYPTO := true
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true

#TWRP Specific build flags
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.date.utc;ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental;ro.product.device=ro.product.system.device;ro.product.model=ro.product.system.model;ro.product.name=ro.product.system.name"
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TW_USE_FSCRYPT_POLICY := 1
TW_SCREEN_BLANK_ON_BOOT := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
#TW_INPUT_BLACKLIST := "hbtp_vm"
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
endif

#Extras
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_SUPPORTS_64_BIT_APPS := true