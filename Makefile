#makefile
BUILD_DIR := build
SRC_DIR   := src
INC_DIR   := inc

CC = C:/tool/2020-q4-major/bin/arm-none-eabi-gcc
LD = C:/tool/2020-q4-major/bin/arm-none-eabi-ld
AR = C:/tool/2020-q4-major/bin/arm-none-eabi-ar
OBJCOPY = C:/tool/2020-q4-major/bin/arm-none-eabi-objcopy

INCLUDES += -I$(INC_DIR)

FILE_TO_LINK = $(BUILD_DIR)/startup_stm32f103xb.o $(BUILD_DIR)/main.o  $(BUILD_DIR)/system_stm32f10x.o

LINKER_FILE := stm32f103c8_flash.ld

CFLAGS = -O0 -g -Wall -fno-strict-aliasing -I.\
    -mcpu=cortex-m3 -mthumb \
    $(INCLUDES) -DSTM32F10X_MD -DUSE_STDPERIPH_DRIVER

LDFLAGS += -T$(LINKER_FILE) -mthumb -mcpu=cortex-m3 -nostdlib

LD_OPT	:= -T $(LINKER_FILE) -Map $(BUILD_DIR)/build.map $(FILE_TO_LINK)

$(BUILD_DIR)/main.o : $(SRC_DIR)/main.c
	$(CC) -c $(CFLAGS) $< -o $@
$(BUILD_DIR)/startup_stm32f103xb.o : $(SRC_DIR)/startup_stm32f103xb.S
	$(CC) -c $(CFLAGS) $< -o $@
$(BUILD_DIR)/system_stm32f10x.o : $(SRC_DIR)/system_stm32f10x.c
	$(CC) -c $(CFLAGS) $< -o $@
build: $(FILE_TO_LINK)
	$(LD) $(LD_OPT) -o $(BUILD_DIR)/build.elf
	$(OBJCOPY) $(BUILD_DIR)/build.elf -O ihex $(BUILD_DIR)/build.hex
clean:
	rm -rf $(BUILD_DIR)/*