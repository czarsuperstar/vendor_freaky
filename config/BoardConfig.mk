include vendor/freaky/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/freaky/config/BoardConfigQcom.mk
endif

include vendor/freaky/config/BoardConfigSoong.mk

ifneq ($(TARGET_USES_PREBUILT_CAMERA_SERVICE), true)
PRODUCT_SOONG_NAMESPACES += \
    frameworks/av/camera/cameraserver \
    frameworks/av/services/camera/libcameraservice
endif

# Namespace for fwk-detect
TARGET_FWK_DETECT_PATH ?= hardware/qcom-caf/common
PRODUCT_SOONG_NAMESPACES += \
    $(TARGET_FWK_DETECT_PATH)/fwk-detect

# Enable real time lockscreen charging current values
BOARD_GLOBAL_CFLAGS += -DBATTERY_REAL_INFO
