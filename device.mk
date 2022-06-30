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

#Pen
#BUILD_PREBUILT += \
#    $(LOCAL_PATH)/prebuilt/touchPen/TouchPenService/TouchPenService.apk:$(TARGET_COPY_OUT_RECOVERY)/root/system_ext/priv-app/TouchPenService/TouchPenService.apk \
#    $(LOCAL_PATH)/prebuilt/touchPen/TouchPenService/oat/arm64/TouchPenService.odex:$(TARGET_COPY_OUT_RECOVERY)/root/system_ext/priv-app/TouchPenService/oat/arm64/TouchPenService.odex \
#    $(LOCAL_PATH)/prebuilt/touchPen/TouchPenService/oat/arm64/TouchPenService.vdex:$(TARGET_COPY_OUT_RECOVERY)/root/system_ext/priv-app/TouchPenService/oat/arm64/TouchPenService.vdex

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/touchPen/vendor.surface.touchpen@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.surface.touchpen@1.0.so \
    $(LOCAL_PATH)/prebuilt/touchPen/vendor.surface.touchpen@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.surface.touchpen@1.0-service \
    $(LOCAL_PATH)/prebuilt/touchPen/vendor.surface.touchpen@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.surface.touchpen@1.0-service.rc
    #$(LOCAL_PATH)/prebuilt/touchPen/hiddenapi-package-whitelist-TouchPenService.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system_ext/etc/sysconfig/hiddenapi-package-whitelist-TouchPenService.xml \
    #$(LOCAL_PATH)/prebuilt/touchPen/privapp-permissions-TouchPenService.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system_ext/etc/permissions/privapp-permissions-TouchPenService.xml
    
PRODUCT_PACKAGES += \
    vendor.surface.touchpen@1.0 \
    vendor.surface.touchpen@1.0-service

#Touch
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/touch/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.touchscreen.multitouch.jazzhand.xml \
    $(LOCAL_PATH)/prebuilt/touch/init.surface.touch.preloads.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.surface.touch.preloads.sh \
    $(LOCAL_PATH)/prebuilt/touch/libsurfacetouch.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsurfacetouch.so \
    $(LOCAL_PATH)/prebuilt/touch/surface_touchscreen.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/surface_touchscreen.idc \
    #$(LOCAL_PATH)/prebuilt/touch/systemtouch:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/touch \
    #$(LOCAL_PATH)/prebuilt/touch/vendortouch:$(TARGET_COPY_OUT_VENDOR)/bin/touch

PRODUCT_PACKAGES += \
    libsurfacetouch

# Uevent
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc
