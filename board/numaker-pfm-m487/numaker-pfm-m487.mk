NAME := numaker-pfm-m487

$(NAME)_TYPE         := kernel
MODULE               := 1062
HOST_ARCH            := Cortex-M4
HOST_MCU_FAMILY      := m487jidae
SUPPORT_BINS         := no
ENABLE_VFP           := 1
CONFIG_SYSINFO_PRODUCT_MODEL := ALI_AOS_NUMAKER_M487
CONFIG_SYSINFO_DEVICE_NAME := $(NAME)
CONFIG_SYSINFO_OS_VERSION := 100

#GLOBAL_DEFINES += CONFIG_AOS_KV_MULTIPTN_MODE
GLOBAL_DEFINES += CONFIG_AOS_KV_PTN=5
#GLOBAL_DEFINES += CONFIG_AOS_KV_SECOND_PTN=7
GLOBAL_DEFINES += CONFIG_AOS_KV_PTN_SIZE=4096
GLOBAL_DEFINES += CONFIG_AOS_KV_BUFFER_SIZE=8192

$(NAME)_SOURCES += \
		   aos/board.c \
                   aos/soc_init.c \
                   aos/board_cli.c
                   
$(NAME)_SOURCES += startup_M480.c 

GLOBAL_INCLUDES += . \
                   hal/ \
                   aos/ \
                   inc/
				   
GLOBAL_CFLAGS += -DNUMICRO_M487

GLOBAL_DEFINES += STDIO_UART=0
GLOBAL_DEFINES += STDIO_UART_BUADRATE=115200
GLOBAL_DEFINES += CONFIG_AOS_CLI_BOARD

#ETHERNET := 1
#WIFI  := 0

ifeq ($(ETHERNET),1)
$(NAME)_COMPONENTS  += lwIP
no_with_lwip := 0
press_test := 1
HW_CRYPTO_AES_NUVOTON := 1
GLOBAL_DEFINES += WITH_LWIP
GLOBAL_DEFINES += LWIP_MAILBOX_QUEUE
GLOBAL_DEFINES += LWIP_TIMEVAL_PRIVATE=0
else ifeq ($(WIFI),1)
SAL := 0
press_test := 1
no_with_lwip := 1
$(NAME)_COMPONENTS  += sal sal.wifi.mk3060
GLOBAL_DEFINES += WITH_SAL
GLOBAL_DEFINES += DEV_SAL_MK3060
else
GLOBAL_DEFINES += CONFIG_NO_TCPIP
endif


ifeq ($(COMPILER),armcc)
$(NAME)_LINK_FILES := startup_M480.o
endif

GLOBAL_CFLAGS += -DSYSINFO_OS_VERSION=\"$(CONFIG_SYSINFO_OS_VERSION)\"
GLOBAL_CFLAGS += -DSYSINFO_PRODUCT_MODEL=\"$(CONFIG_SYSINFO_PRODUCT_MODEL)\"
GLOBAL_CFLAGS += -DSYSINFO_DEVICE_NAME=\"$(CONFIG_SYSINFO_DEVICE_NAME)\"
GLOBAL_CFLAGS += -DSYSINFO_ARCH=\"$(HOST_ARCH)\"
GLOBAL_CFLAGS += -DSYSINFO_MCU=\"$(HOST_MCU_FAMILY)\"
