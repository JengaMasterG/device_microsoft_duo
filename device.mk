#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/microsoft/duo

#Include Microsoft Vendor Blobs
$(call inherit-product-if-exists, vendor/microsoft/duo/duo-vendor.mk)

# A/B
AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-impl.recovery \
    android.hardware.boot@1.0-service

PRODUCT_PACKAGES += \
    bootctrl.msmnile \
    bootctrl.msmnile.recovery

#Deprecated in 11.0
#PRODUCT_STATIC_BOOT_CONTROL_HAL := \
#    bootctrl.msmnile \
#    libgptutils \
#    libz \
#    libcutils

# Init Scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/etc/init/hw/init.qcom.factory.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.factory.rc \
    $(LOCAL_PATH)/recovery/root/vendor/etc/init/hw/init.qcom.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.rc \
    $(LOCAL_PATH)/recovery/root/vendor/etc/init/hw/init.qcom.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.usb.rc \
    $(LOCAL_PATH)/recovery/root/vendor/etc/init/hw/init.qcom.qti.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.qti.rc \
    $(LOCAL_PATH)/recovery/root/vendor/etc/init/hw/init.surfaceduo.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.surfaceduo.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/vendor/etc/init/hw/init.target.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.target.rc

PRODUCT_PACKAGES += \
    init.surfaceduo.rc \

# Keystore
PRODUCT_PACKAGES +=\
    android.hardware.keymaster@4.1.vendor

#OTA Update Engine
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload
    
#TWRP Decryption
#PRODUCT_COPY_FILES += \
    #$(OUT_DIR)/recovery/root/

PRODUCT_PACKAGES += \
    qseecom \
    qseecomd \
    keymaster \
    gatekeeper \
    qcom_decrypt \
    qcom_decrypt_fbe

# Uevent
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc
