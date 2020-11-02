#
# Makefile for STM32F7 Discovery projects, using a similar structure 
# that in STM32 Cube package.
#
# Directory structure:
#
# Project root
# |
# +-- Build:	Compiled files go here
# |
# +-- Config:	Config files for openocd, ldscripts and startup code. Do not touch.
# |
# +-- Drivers:	STM32Cube libraries
# |
# +-- Inc:      Headers for application code
# |
# +-- Src:      Source code for application (main.c)
# |
# +-- Utilities LCD Fonts, etc
#
# Commands:
#
#	make			Compile project
#	make program	Burn program to STM32 using OpenOCD
#	make clean		Remove compiled files
#

######################################
# system
######################################
SYSTEM = Generic
SYSTEM_PROCESSOR = ARM
SYSTEM_ARCH = ARMv7E-M
CPU_FAMILY = STM32F7xx
CPU_CORE = cortex-m7
CPU_ENDIAN = little-endian
CPU_MODEL_GENERAL = STM32F746xx
BOARD_NAME = STM32746G-Discovery

######################################
# target
######################################
TARGET = LwIP_Http_Server_Netconn_FreeRTOS_STM32F7DISCO

######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization
OPT = -Og

#######################################
# paths
#######################################
# Build Path
BUILD_DIR = ./Build

#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx) or can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S

######################################
# source
######################################
# Hal Sourch Files
HAL_SOURCES =
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_cortex.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dma.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dma2d.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_eth.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash_ex.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_gpio.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_i2c.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_i2c_ex.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_ltdc.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr_ex.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc_ex.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_sdram.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_tim.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_tim_ex.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_uart.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal.c
HAL_SOURCES += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_ll_fmc.c
# RTOS Source Files
RTOS_SOURCES =
RTOS_SOURCES += Middlewares/FreeRTOS/Source/CMSIS_RTOS/cmsis_os.c
RTOS_SOURCES += Middlewares/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1/port.c
RTOS_SOURCES += Middlewares/FreeRTOS/Source/portable/MemMang/heap_4.c
RTOS_SOURCES += Middlewares/FreeRTOS/Source/croutine.c
RTOS_SOURCES += Middlewares/FreeRTOS/Source/list.c
RTOS_SOURCES += Middlewares/FreeRTOS/Source/queue.c
RTOS_SOURCES += Middlewares/FreeRTOS/Source/tasks.c
RTOS_SOURCES += Middlewares/FreeRTOS/Source/timers.c
# CMSIS Source Files
CMSIS_SOURCES =
CMSIS_SOURCES += Src/system_stm32f7xx.c
# Utilities Source Files
UTILITIES_SOURCES =
UTILITIES_SOURCES += Utilities/Log/lcd_log.c
# BSP Source Files
BSP_SOURCES =
BSP_SOURCES += Drivers/BSP/STM32746G-Discovery/stm32746g_discovery.c
BSP_SOURCES += Drivers/BSP/STM32746G-Discovery/stm32746g_discovery_sdram.c
BSP_SOURCES += Drivers/BSP/STM32746G-Discovery/stm32746g_discovery_lcd.c
# LwIP Directory Path
LWIP_DIR = ./Middlewares/LwIP
# LwIP Core Source Files
LWIP_CORE_SOURCES =
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/init.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/def.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/dns.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/inet_chksum.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/ip.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/mem.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/memp.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/netif.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/pbuf.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/raw.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/stats.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/sys.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/altcp.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/altcp_alloc.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/altcp_tcp.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/tcp.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/tcp_in.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/tcp_out.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/timeouts.c
LWIP_CORE_SOURCES += $(LWIP_DIR)/src/core/udp.c
# LwIP Core IPv4 Source Files
LWIP_CORE4_SOURCES =  
LWIP_CORE4_SOURCES += $(LWIP_DIR)/src/core/ipv4/autoip.c
LWIP_CORE4_SOURCES += $(LWIP_DIR)/src/core/ipv4/dhcp.c
LWIP_CORE4_SOURCES += $(LWIP_DIR)/src/core/ipv4/etharp.c
LWIP_CORE4_SOURCES += $(LWIP_DIR)/src/core/ipv4/icmp.c
LWIP_CORE4_SOURCES += $(LWIP_DIR)/src/core/ipv4/igmp.c
LWIP_CORE4_SOURCES += $(LWIP_DIR)/src/core/ipv4/ip4_frag.c
LWIP_CORE4_SOURCES += $(LWIP_DIR)/src/core/ipv4/ip4.c
LWIP_CORE4_SOURCES += $(LWIP_DIR)/src/core/ipv4/ip4_addr.c
# LwIP API Source Files
LWIP_API_SOURCES =  
LWIP_API_SOURCES += $(LWIP_DIR)/src/api/api_lib.c
LWIP_API_SOURCES += $(LWIP_DIR)/src/api/api_msg.c
LWIP_API_SOURCES += $(LWIP_DIR)/src/api/err.c
LWIP_API_SOURCES += $(LWIP_DIR)/src/api/if_api.c
LWIP_API_SOURCES += $(LWIP_DIR)/src/api/netbuf.c
LWIP_API_SOURCES += $(LWIP_DIR)/src/api/netdb.c
LWIP_API_SOURCES += $(LWIP_DIR)/src/api/netifapi.c
LWIP_API_SOURCES += $(LWIP_DIR)/src/api/sockets.c
LWIP_API_SOURCES += $(LWIP_DIR)/src/api/tcpip.c
# LwIP Netif Source Files
LWIP_NETIF_SOURCES = 
LWIP_NETIF_SOURCES += $(LWIP_DIR)/src/netif/ethernet.c
LWIP_NETIF_SOURCES += $(LWIP_DIR)/src/netif/bridgeif.c
LWIP_NETIF_SOURCES += $(LWIP_DIR)/src/netif/bridgeif_fdb.c
LWIP_NETIF_SOURCES += $(LWIP_DIR)/src/netif/slipif.c
# LwIP HTTP Source Files
LWIP_HTTP_SOURCES =
LWIP_HTTP_SOURCES += $(LWIP_DIR)/src/apps/http/altcp_proxyconnect.c
LWIP_HTTP_SOURCES += $(LWIP_DIR)/src/apps/http/fs.c
LWIP_HTTP_SOURCES += $(LWIP_DIR)/src/apps/http/http_client.c
LWIP_HTTP_SOURCES += $(LWIP_DIR)/src/apps/http/httpd.c
# LwIP Source Files
LWIP_SOURCES =
LWIP_SOURCES += $(LWIP_DIR)/system/OS/sys_arch.c
LWIP_SOURCES += $(LWIP_CORE_SOURCES)
LWIP_SOURCES += $(LWIP_CORE4_SOURCES)
LWIP_SOURCES += $(LWIP_API_SOURCES)
LWIP_SOURCES += $(LWIP_NETIF_SOURCES)
LWIP_SOURCES += $(LWIP_HTTP_SOURCES)
# Application Source Files
APP_SOURCES =
APP_SOURCES += Src/app_ethernet.c
APP_SOURCES += Src/ethernetif.c
APP_SOURCES += Src/httpserver-netconn.c
APP_SOURCES += Src/main.c
APP_SOURCES += Src/stm32f7xx_hal_timebase_tim.c
APP_SOURCES += Src/stm32f7xx_it.c
APP_SOURCES += syscalls.c
# All C Source Files
C_SOURCES = 
C_SOURCES += $(HAL_SOURCES)
C_SOURCES += $(RTOS_SOURCES)
C_SOURCES += $(UTILITIES_SOURCES)
C_SOURCES += $(CMSIS_SOURCES)
C_SOURCES += $(BSP_SOURCES)
C_SOURCES += $(LWIP_SOURCES)
C_SOURCES += $(APP_SOURCES)

# ASM Source Files
ASM_SOURCES = 
ASM_SOURCES += startup_stm32f746xx.s



# Project Objective Files
HAL_OBJS = $(HAL_SOURCES:.c=.o)
RTOS_OBJS = $(RTOS_SOURCES:.c=.o)
CMSIS_OBJS = $(CMSIS_SOURCES:.c=.o)
UTILITIES_OBJS = $(UTILITIES_SOURCES:.c=.o)
BSP_OBJS = $(BSP_SOURCES:.c=.o)
LWIP_OBJS = $(LWIP_SOURCES:.c=.o)


#######################################
# CFLAGS
#######################################
# Core
CPU = -mcpu=$(CPU_CORE)
# FPU
FPU = -mfpu=fpv5-sp-d16
# Float-ABI
FLOAT-ABI = -mfloat-abi=hard
# Endian
ENDIAN = -m$(CPU_ENDIAN)
# MCU
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI) $(ENDIAN)
# AS defines
AS_DEFS = 
# C defines
C_DEFS = 
C_DEFS += -DUSE_HAL_DRIVER 
C_DEFS += -D$(CPU_MODEL_GENERAL)
C_DEFS += -DARM_MATH_CM7
C_DEFS += -D__FPU_PRESENT=1
C_DEFS += -DUSE_STM32746G_DISCOVERY

# AS includes
AS_INCLUDES = 
AS_INCLUDES += -IInc
# C Includes
C_INCLUDES =
#Src Dir
C_INCLUDES += -IInc
#BSP Dir
C_INCLUDES += -IDrivers/BSP/STM32746G-Discovery
C_INCLUDES += -IDrivers/BSP/Components/rk043fn48h
#HAL Dir
C_INCLUDES += -IDrivers/STM32F7xx_HAL_Driver/Inc
C_INCLUDES += -IDrivers/STM32F7xx_HAL_Driver/Inc/Legacy
#CMSIS Dir
C_INCLUDES += -IDrivers/CMSIS/Device/ST/$(CPU_FAMILY)/Include
C_INCLUDES += -IDrivers/CMSIS/Core/Include
#FreeRTOS Dir
C_INCLUDES += -IMiddlewares/FreeRTOS/Source/include
C_INCLUDES += -IMiddlewares/FreeRTOS/Source/CMSIS_RTOS
C_INCLUDES += -IMiddlewares/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1
#Utilities Dir
C_INCLUDES += -IUtilities/Fonts
C_INCLUDES += -IUtilities/Log
#LwIP Dir
C_INCLUDES += -IMiddlewares/LwIP/src/include
C_INCLUDES += -IMiddlewares/LwIP/src/include/lwip
C_INCLUDES += -IMiddlewares/LwIP/system
C_INCLUDES += -ISrc

# compile gcc fls
ASFLAGS = $(MCU)(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections
CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections
ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif
# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = STM32F746NGHx_FLASH.ld

# libraries
LIBS = -lc -lm -lnosys
#LIBS += -lhal 
#LIBS += -lrtos 
#LIBS += -lcmsis 
#LIBS += -lutilities 
#LIBS += -llwip
# Libraries Directoies
LIBDIR = 
LIBDIR += -L$(BUILD_DIR)
# Linking flags
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections


#######################################
# build the application
#######################################
# Build Print
BUILD_PRINT = "\033[0;32mBuilding $< -> $@ \033[0m"
LINK_PRINT = "\033[0;32mLinking $< -> $@\033[0m"
OUTPUT_PRINT = "\033[0;32mOutput $< -> $@\033[0m"
BUILD_DIR_PRINT = "\033[0;32mMaking Build Directory ($@)\033[0m"

# list of C program objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

all: $(BUILD_DIR)/$(TARGET).bin $(BUILD_DIR)/$(TARGET).hex

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	@echo $(BUILD_PRINT)
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR) 
	@echo $(BUILD_PRINT)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	@echo $(LINK_PRINT)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/$(TARGET).hex: $(BUILD_DIR)/$(TARGET).elf | $(BUILD_DIR)
	@echo $(OUTPUT_PRINT)
	$(HEX) $< $@
	
$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf | $(BUILD_DIR)
	@echo $(OUTPUT_PRINT)
	$(BIN) $< $@	
	
$(BUILD_DIR):
	@echo $(BUILD_PRINT)
	mkdir $@		

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)


