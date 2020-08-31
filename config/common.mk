PRODUCT_BRAND ?= FreakyOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.setupwizard.rotation_locked=true

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# OmniStyle [Header Image]
PRODUCT_PACKAGES += \
    OmniStyle

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/freaky/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/freaky/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/freaky/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh

# OTA
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/freaky/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/freaky/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/freaky/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Some permissions
PRODUCT_COPY_FILES += \
    vendor/freaky/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/freaky/config/permissions/privapp-permissions-fm.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-fm.xml \
    vendor/freaky/config/permissions/privapp-permissions-snap.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-snap.xml \
    vendor/freaky/config/permissions/privapp-permissions-camera2.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-camera2.xml \
    vendor/freaky/config/permissions/privapp-permissions-freaky-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-freaky-product.xml \
    vendor/freaky/config/permissions/privapp-permissions-google_prebuilt.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-google_prebuilt.xml \
    vendor/freaky/config/permissions/privapp-permissions-lineagehw.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-lineagehw.xml

# Copy all custom init rc files
$(foreach f,$(wildcard vendor/freaky/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/freaky/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/freaky/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/freaky/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/freaky/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/freaky/overlay/common

# TouchGestures
PRODUCT_PACKAGES += \
    TouchGestures

# PixelSetupWizard overlay
PRODUCT_PACKAGES += \
    PixelSetupWizardOverlay \
    PixelSetupWizardAodOverlay

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    NexusLauncherRelease

# Themed bootanimation
TARGET_MISC_BLOCK_OFFSET ?= 0
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.misc.block.offset=$(TARGET_MISC_BLOCK_OFFSET)
PRODUCT_PACKAGES += \
    misc_writer_system \
    themed_bootanimation

# Screen recorder
PRODUCT_PACKAGES += \
    Terminal

# Long Screenshot
PRODUCT_PACKAGES += \
    StitchImage

# Extra tools in Havoc
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# LatinIME lib
PRODUCT_PACKAGES += \
    libjni_latinimegoogle

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Enable ccache
USE_CCACHE := true

# Allows registering device to Google easier for gapps
# Integrates package for easier Google Pay fixing
PRODUCT_PACKAGES += \
    sqlite3

# TWRP Recovery
ifeq ($(WITH_TWRP),true)
RECOVERY_VARIANT := twrp
endif

# Face Unlock
ifeq ($(CUSTOM_BUILD_TYPE), $(filter $(CUSTOM_BUILD_TYPE), OFFICIAL))
TARGET_FACE_UNLOCK_SUPPORTED := false
ifeq ($(TARGET_ARCH), $(filter $(TARGET_ARCH), arm64))
ifneq ($(TARGET_DISABLE_ALTERNATIVE_FACE_UNLOCK), true)
PRODUCT_PACKAGES += \
    FaceUnlockService

TARGET_FACE_UNLOCK_SUPPORTED := true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face.moto_unlock_service=$(TARGET_FACE_UNLOCK_SUPPORTED)
endif
endif
endif

# Zygote preforking
PRODUCT_PROPERTY_OVERRIDES += \
    persist.device_config.runtime_native.usap_pool_enabled=true

# Branding
include vendor/freaky/config/branding.mk

# OTA
include vendor/freaky/config/ota.mk

# FreakyOS Style
include vendor/freaky/freakystyle/config.mk

# Customization
include vendor/google-customization/config.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
