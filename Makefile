CC = arm-none-eabi-gcc
CFLAGS = -c -mcpu=cortex-m4 -mthumb -std=gnu11
LDFLAGS = -nostdlib -T stm32_ls.ld -Wl,-Map=project.map

final : project.elf

main.o : main.c
	$(CC) $(CFLAGS) $^ -o $@

stm32f401_startup.o : stm32f401_startup.c
	$(CC) $(CFLAGS) $^ -o $@

project.elf : main.o stm32f401_startup.o
	$(CC) $(LDFLAGS) $^ -o $@

clean :
	rm -f *.o *.elf *.map
