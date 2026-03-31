python3 _tools/jwasm_run.py -bin bios.ASM
..\tool\biossum bios.bin bios.abs
cat ..\fill32.bin ..\fill32.bin ..\fill48.bin bios.abs >rom.rom