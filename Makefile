.PHONY: default
default: all

include Config.mk

ANDROID_SDK_ROOT = $(HOME)/Android/Sdk
ANDROID_NDK_VERSION = $(shell ls $(ANDROID_SDK_ROOT)/ndk | sort -nr | tail -1)
ANDROID_NDK_BIN=$(ANDROID_SDK_ROOT)/ndk/$(ANDROID_NDK_VERSION)/toolchains/llvm/prebuilt/linux-x86_64/bin
ANDROID_NDK_CROSS = $(ANDROID_NDK_BIN)/$(NDK_CROSS_PREFIX)
NDKCC_PATH = $(ANDROID_NDK_BIN)/$(NDKCC)

# src loc
SRC_DIR = LuaJIT/src

# dest loc
# how about dist/android/${LIB_ARCH}/ ?
DIST_DIR = dist
DIST_ARCH_DIR = $(DIST_DIR)/android/$(LIB_ARCH)
DIST_LIB_DIR = $(DIST_ARCH_DIR)/lib
DIST_BIN_DIR = $(DIST_ARCH_DIR)/bin
DIST_INC_DIR = $(DIST_ARCH_DIR)/include
DIST_JIT_DIR = $(DIST_ARCH_DIR)/jit
# ... or maybe share/jit?

LUAJIT_SO = $(DIST_LIB_DIR)/libluajit.so

$(LUAJIT_SO): $(shell find $(SRC_DIR) -type f -name "*.c")
	cd $(SRC_DIR) \
		&& make clean \
		&& make \
			Q= \
			E="@:" \
			XCFLAGS=-DLUAJIT_ENABLE_LUA52COMPAT \
			TARGET_SONAME=libluajit.so \
			TARGET_DYLIBNAME=libluajit.dylib \
			TARGET_DLLNAME=luajit.dll \
			TARGET_DLLDOTANAME=libluajit.dll.a \
			$(HOST_CC) \
			CROSS=$(ANDROID_NDK_CROSS) \
			STATIC_CC=$(NDKCC_PATH) \
			DYNAMIC_CC="$(NDKCC_PATH) -fPIC" \
			TARGET_LD=$(NDKCC_PATH) \
			TARGET_AR="$(ANDROID_NDK_BIN)/llvm-ar rcus" \
			TARGET_STRIP=$(ANDROID_NDK_BIN)/llvm-strip
	mkdir -p $(DIST_LIB_DIR)
	cp \
		$(SRC_DIR)/libluajit.so \
		$(DIST_LIB_DIR)/libluajit.so
	cp \
		$(SRC_DIR)/libluajit.a \
		$(DIST_LIB_DIR)/libluajit.a
	mkdir -p $(DIST_BIN_DIR)
	cp \
		$(SRC_DIR)/luajit \
		$(DIST_BIN_DIR)/luajit
	mkdir -p $(DIST_INC_DIR)
	cp $(SRC_DIR)/lauxlib.h $(DIST_INC_DIR)/
	cp $(SRC_DIR)/luaconf.h $(DIST_INC_DIR)/
	cp $(SRC_DIR)/lua.h $(DIST_INC_DIR)/
	cp $(SRC_DIR)/lua.hpp $(DIST_INC_DIR)/
	cp $(SRC_DIR)/luajit.h $(DIST_INC_DIR)/
	cp $(SRC_DIR)/lualib.h $(DIST_INC_DIR)/
	cp $(SRC_DIR)/lj_arch.h $(DIST_INC_DIR)/
	mkdir -p $(DIST_JIT_DIR)
	cp $(SRC_DIR)/jit/*.lua $(DIST_JIT_DIR)

.PHONY: all
all: $(LUAJIT_SO)

.PHONY: clean
clean:
	-rm -rf $(DIST_DIR)
