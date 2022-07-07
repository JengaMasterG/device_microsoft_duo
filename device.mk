#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

#Include Microsoft Vendor Blobs
$(call inherit-product-if-exists, vendor/microsoft/duo/duo-vendor.mk)

# A/B support
AB_OTA_UPDATER := true

# A/B
AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor \
    vbmeta \
    dtbo

# A/B support
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl.recovery \
    android.hardware.health@2.1-impl.recovery \
    bootctrl.$(PRODUCT_PLATFORM).recovery

PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libandroidicu.so

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport \
    libhwbinder

#Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

#File Based Encryption (FBE)
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

#Pen
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/prebuilt/touchPen/vendor.surface.touchpen@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.surface.touchpen@1.0.so \
    $(DEVICE_PATH)/prebuilt/touchPen/vendor.surface.touchpen@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.surface.touchpen@1.0-service \
    $(DEVICE_PATH)/prebuilt/touchPen/vendor.surface.touchpen@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.surface.touchpen@1.0-service.rc \
    $(DEVICE_PATH)/prebuilt/touch/init.surface.touch.preloads.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.surface.touch.preloads.sh

PRODUCT_PACKAGES += \
    vendor.surface.touchpen@1.0 \
    vendor.surface.touchpen@1.0-service

#Touch
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/prebuilt/touch/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.touchscreen.multitouch.jazzhand.xml \
    $(DEVICE_PATH)/prebuilt/touch/init.qti.display.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.qti.display.rc \
    $(DEVICE_PATH)/prebuilt/touch/libsurfacetouch.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsurfacetouch.so \
    $(DEVICE_PATH)/prebuilt/touch/surface_touchscreen.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/surface_touchscreen.idc \
    $(DEVICE_PATH)/prebuilt/touch/init.qti.display.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/init.qti.display.sh

PRODUCT_PACKAGES += \
    libsurfacetouch
