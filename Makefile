CFLAGS = -Osri -Cl
DEPS =

chip8-emulator.prg: chip8-emulator.s chip8-emulator.o
	ld65  --cfg-path . -C c16-mem.cfg -o chip8-emulator.prg chip8-emulator.o c16.lib
chip8-emulator.d64: chip8-emulator.prg
	cc1541 -q -f chip8-emulator -w chip8-emulator.prg -n chip8-emulator chip8-emulator.d64
%.o: %.s
	ca65 -t c16 -o $@ $<
%.s: %.c
	cc65 $(CFLAGS) --add-source -t c16 -o $@ $<
clean:
	rm -f main.o main.s *.d64 *.prg
test: chip8-emulator.d64
	xplus4 -model c16 +warp chip8-emulator.d64