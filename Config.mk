# config / common vars based on $ARCH, which you can override...

# switch for the ndk cross-compiler stuff.  pick one:
#ARCH ?= arm_32
ARCH ?= arm_64
#ARCH ?= x86_32
#ARCH ?= x86_64

	# arm 32
LIB_ARCH_arm_32 = armeabi-v7a
NDK_CROSS_PREFIX_arm_32 = arm-linux-androideabi-
NDKCC_arm_32 = armv7a-linux-androideabi35-clang
HOST_CC_arm_32 = HOST_CC="gcc -m32"
	# arm 64
LIB_ARCH_arm_64 = arm64-v8a
NDK_CROSS_PREFIX_arm_64 = aarch64-linux-android-
NDKCC_arm_64 = aarch64-linux-android35-clang
HOST_CC_arm_64 =
	# x86 32
LIB_ARCH_x86_32 = x86
NDK_CROSS_PREFIX_x86_32 = i686-linux-android-
NDKCC_x86_32 = i686-linux-android35-clang
HOST_CC_x86_32 = HOST_CC="gcc -m32"
	# x86 64
LIB_ARCH_x86_64 = x86_64
NDK_CROSS_PREFIX_x86_64 = x86_64-linux-android-
NDKCC_x86_64 = x86_64-linux-android35-clang
HOST_CC_x86_64 =

	# switch
LIB_ARCH = $(LIB_ARCH_$(ARCH))
NDK_CROSS_PREFIX = $(NDK_CROSS_PREFIX_$(ARCH))
NDKCC = $(NDKCC_$(ARCH))
HOST_CC = $(HOST_CC_$(ARCH))


# common vars:
# maybe put them in another more foundational repo ...

ANDROID_SDK_ROOT = $(HOME)/Android/Sdk
ANDROID_NDK_VERSION = $(shell ls $(ANDROID_SDK_ROOT)/ndk | sort -nr | tail -1)
ANDROID_NDK_HOME=$(ANDROID_SDK_ROOT)/ndk/$(ANDROID_NDK_VERSION)
ANDROID_NDK_PREBUILT=$(ANDROID_NDK_HOME)/toolchains/llvm/prebuilt/linux-x86_64
ANDROID_NDK_BIN=$(ANDROID_NDK_PREBUILT)/bin
ANDROID_NDK_CROSS = $(ANDROID_NDK_BIN)/$(NDK_CROSS_PREFIX)
NDKCC_PATH = $(ANDROID_NDK_BIN)/$(NDKCC)

# not used by luajit-lib, but everything else here is common to everyone else so why not...
ANDROID_STUDIO_ROOT = $(HOME)/android-studio
ANDROID_PLATFORM_VERSION = $(shell ls $(ANDROID_SDK_ROOT)/platforms | sort -nr | tail -1)
ANDROID_PLATFORM_DIR = $(ANDROID_SDK_ROOT)/platforms/$(ANDROID_PLATFORM_VERSION)
BUILD_TOOLS_VERSION = $(shell ls $(ANDROID_SDK_ROOT)/build-tools | sort -n |tail -1)
BUILD_TOOLS_DIR = $(ANDROID_SDK_ROOT)/build-tools/$(BUILD_TOOLS_VERSION)
ANDROID_JAR = $(ANDROID_PLATFORM_DIR)/android.jar
