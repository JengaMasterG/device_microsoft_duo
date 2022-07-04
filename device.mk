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

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

#OTA Update Engine
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

#Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    vendor/qcom/opensource/commonsys-intf/display \
    external/icu

#File Based Encryption (FBE)
BOARD_USES_QCOM_FBE_DECRYPTION := true

PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Additional Binaries $ libraries needed for recovery
PRODUCT_HOST_PACKAGES += \
    libandroidicu.so

TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0 \
    libdisplayconfig.qti

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so

#PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libandroidicu.so

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
