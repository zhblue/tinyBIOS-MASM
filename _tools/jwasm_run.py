#!/usr/bin/env python3
"""Wrapper to run JWasm with proper Wine settings."""
import subprocess
import os
import sys

# Find JWasm.exe - look in _tools relative to this script's location
script_dir = os.path.dirname(os.path.abspath(__file__))
jwasm_exe = os.path.join(script_dir, "JWasm.exe")

# Get the directory of the source file for include paths
os.chdir(os.path.join(script_dir, '..'))  # Change to tb13-masm directory

args = sys.argv[1:]  # All arguments after the script name

env = os.environ.copy()
env['WINEPREFIX'] = os.path.expanduser('~/.wine32')

cmd = ['wine', jwasm_exe] + args
result = subprocess.run(cmd, env=env, capture_output=True, text=True)
print(result.stdout, end='')
print(result.stderr, end='')
sys.exit(result.returncode)
