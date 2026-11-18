CC      = arm-none-eabi-gcc
ARCH    = -mcpu=cortex-m4 -mthumb -mfloat-abi=soft

CFLAGS  = -c $(ARCH) -std=gnu11 -Wall -O0 -g -DSTM32F401xE -ICMSIS/Core/Include -ICMSIS/Device/Include
LDFLAGS = $(ARCH) --specs=rdimon.specs -T stm32_ls.ld -Wl,-Map=project.map

OBJS = main.o stm32f401_startup.o CMSIS/Device/Source/system_stm32f4xx.o

all: firmware.elf

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

firmware.elf: $(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@

clean:
	rm -f $(OBJS) firmware.elf project.map

flash:
	openocd -f board/st_nucleo_f4.cfg -c "program firmware.elf verify reset exit"

.PHONY: all clean flash
