#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/embedded.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit from duo device
$(call inherit-product-if-exists, device/microsoft/duo/device.mk)

# Inherit some common TWRP stuff.
$(call inherit-product-if-exists, vendor/twrp/config/common.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := duo
PRODUCT_NAME := duo
PRODUCT_BRAND := surface
PRODUCT_MODEL := Surface Duo
PRODUCT_MANUFACTURER := microsoft
