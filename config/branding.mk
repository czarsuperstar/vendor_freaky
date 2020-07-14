# Set all versions
CUSTOM_BUILD_TYPE ?= UNOFFICIAL

CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_DATE_HOUR := $(shell date -u +%H)
CUSTOM_DATE_MINUTE := $(shell date -u +%M)
CUSTOM_BUILD_DATE_UTC := $(shell date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) $(CUSTOM_DATE_HOUR):$(CUSTOM_DATE_MINUTE) UTC' +%s)
CUSTOM_BUILD_DATE := $(CUSTOM_DATE_YEAR)$(CUSTOM_DATE_MONTH)$(CUSTOM_DATE_DAY)-$(CUSTOM_DATE_HOUR)$(CUSTOM_DATE_MINUTE)

CUSTOM_PLATFORM_VERSION := 10.0

BUILD_OS_NAME := FreakyOS
FREAKY_VER := ver[X]

TARGET_PRODUCT_SHORT := $(subst freaky_,,$(CUSTOM_BUILD))

CUSTOM_VERSION := FreakyOS_$(FREAKY_VER)-$(CUSTOM_BUILD)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_BUILD_TYPE)
CUSTOM_VERSION_PROP := 10

CUSTOM_PROPERTIES := \
    org.freaky.version=$(CUSTOM_VERSION_PROP) \
    org.freaky.version.display=$(CUSTOM_VERSION) \
    org.freaky.build_date=$(CUSTOM_BUILD_DATE) \
    org.freaky.build_date_utc=$(CUSTOM_BUILD_DATE_UTC) \
    org.freaky.build_type=$(CUSTOM_BUILD_TYPE) \
    org.freaky.build_version=$(FREAKY_VER) \
    org.build.osname=$(BUILD_OS_NAME)

# Releasekey
ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)
SIGNING_KEYS := vendor/freaky/config/.releasekey
ifneq ($(SIGNING_KEYS),)
PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif
endif