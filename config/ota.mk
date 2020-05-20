ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)

PRODUCT_PACKAGES += \
    Updater

PRODUCT_COPY_FILES += \
    vendor/freaky/config/permissions/org.freaky.updater.xml:system/etc/permissions/org.freaky.updater.xml

endif
