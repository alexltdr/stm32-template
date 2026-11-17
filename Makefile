CC      = arm-none-eabi-gcc
MACH    = cortex-m4
ARCH    = -mcpu=$(MACH) -mthumb -mfloat-abi=soft

CFLAGS  = -c $(ARCH) -std=gnu11 -Wall -O0 -g
LDFLAGS = $(ARCH) --specs=rdimon.specs -T stm32_ls.ld -Wl,-Map=project.map

OBJS = main.o stm32f401_startup.o

all: project.elf

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

project.elf: $(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@

clean:
	rm -f *.o *.elf *.map

flash: 
	openocd -f board/st_nucleo_f4.cfg -c "program project.elf verify reset exit"
.PHONY: all clean
