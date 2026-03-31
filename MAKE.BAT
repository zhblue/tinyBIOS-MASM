@rem This is for fill patterns only - main BIOS files are part of chipset
@rem directories.
@rem
python3 _tools/jwasm_run.py -bin fill16.ASM
python3 _tools/jwasm_run.py -bin fill32.ASM
python3 _tools/jwasm_run.py -bin fill48.ASM
del fill*.sym