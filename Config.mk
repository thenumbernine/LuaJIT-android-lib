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


