# using wix build -o pars.msi pars.wxs
include ./makefiles/variables.mk
include ./makefiles/init.mk


MSI_PACK_TYPE ?= source
ARCH_FLAG_VALUE := $(strip $(call determine_arch_flag_value))
ARCH_FOLDER := $(strip $(call determine_arch_folder,$(MSI_PACK_TYPE)))
PACK_ROOT_DIR := $(strip $(call determine_pack_dir,$(MSI_PACK_TYPE)))

define arch_to_msi
  $(if $(strip $(1)),\
    $(if $(filter $(ARCH_386),$(1)),i386,\
    $(if $(filter $(ARCH_AMD64),$(1)),x86_64,\
    $(if $(filter $(ARCH_ARM64),$(1)),aarch64,\
    $(if $(filter $(ARCH_ARM),$(1)),armhfp,\
    $(error Unsupported architecture: $(1)))))))
endef

define determine_msi_arch
  $(if $(strip $(ARCH)),\
    $(call arch_to_msi,$(ARCH)),\
    $(if $(filter binary,$(1)),\
      $(call arch_to_msi,$(APP_ARCH)),\
      %{?_arch}))
endef
MSI_PACK_ARCH := $(strip $(call determine_msi_arch,$(MSI_PACK_TYPE)))



MSI_PACKAGE_EXT = .msi
MSI_ROOT_DIR = $(PACKAGE_ROOT_DIR)/msi
MSI_BUILD_ROOT_DIR = $(MSI_ROOT_DIR)/$(PACK_ROOT_DIR)
MSI_BUILD_CONFIG_DIR = $(MSI_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
MSI_BUILD_PAYLOAD_DIR = $(MSI_BUILD_CONFIG_MSI_DIR)/SOURCES
MSI_BUILD_OUTPUT_DIR = $(MSI_BUILD_ROOT_DIR)/output
MSI_BUILD_TEMP_DIR = $(MSI_BUILD_ROOT_DIR)/tmp
MSI_BUILD_OUTPUT_MSI_FILES = $(wildcard $(MSI_BUILD_OUTPUT_DIR)/*$(MSI_PACKAGE_EXT))
MSI_BUILD_CONFIG_MSI_DIR = $(MSI_BUILD_CONFIG_DIR)
MSI_BUILD_CONFIG_WXS_FILE = $(MSI_BUILD_CONFIG_DIR)/$(APPLICATION_NAME).wxs


MSI_RELEASE_DATE_FORMAT := $(shell date -d $(RELEASE_DATE_STD) +"%a %b %d %Y")



msi-init:
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@mkdir -p $(MSI_BUILD_TEMP_DIR)
	@mkdir -p $(MSI_BUILD_CONFIG_MSI_DIR)



$(APPLICATION_NAME).wxs:
	echo "<?xml version='1.0'?>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "<Wix xmlns='http://wixtoolset.org/schemas/v4/wxs'>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "	<Package Name='$(APPLICATION_NAME)' Language='1033' Version='$(APP_TAG_VERSION)' Manufacturer='$(ORGANIZATION)' UpgradeCode='6d171ec4-2a37-5a83-b686-7f2df79cc931' InstallerVersion='500'>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "		<MajorUpgrade DowngradeErrorMessage='A newer version of $(APPLICATION_NAME) is already installed.' />" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "		<Feature Id='ProductFeature' Title='MsiPackage'>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "			<ComponentGroupRef Id='ProductComponents' />" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "		</Feature>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "		<ComponentGroup Id='ProductComponents' Directory='INSTALLFOLDER'>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "			<Component>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "				<File Source='$(APP)' />" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "			</Component>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "			<Component Id='EnvVars' Guid='10bede1b-8042-5b7f-ab13-9b714da6f27d'>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "				<CreateFolder />" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "				<Environment Id='PathEnvVar' Action='set' System='yes' Name='PATH' Part='last' Value='[INSTALLFOLDER]'/>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "			</Component>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "		</ComponentGroup>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "	</Package>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "	<Fragment>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "		<StandardDirectory Id='ProgramFiles64Folder'>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "			<Directory Id='APPFOLDER' Name='$(APPLICATION_NAME)' >" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "				<Directory Id='INSTALLFOLDER' Name='bin' /></Directory>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "		</StandardDirectory>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "		<StandardDirectory Id='AppDataFolder'>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "			<Directory Id='DATAFOLDER' Name='$(APPLICATION_NAME)' >" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "				<Directory Id='DATABASEFOLDER' Name='data' />" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "				<Directory Id='LOGFOLDER' Name='logs' />" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "				<Directory Id='CONFIGFOLDER' Name='config' />" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "				<Directory Id='CACHEFOLDER' Name='cache' /></Directory>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "		</StandardDirectory>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "	</Fragment>" >> $(MSI_BUILD_CONFIG_DIR)/$@
	echo "</Wix>" >> $(MSI_BUILD_CONFIG_DIR)/$@




package.msi.prepare.config: msi-init $(APPLICATION_NAME).wxs

