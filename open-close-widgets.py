#!/bin/python3

import subprocess
import os

used = subprocess.check_output(['eww', 'windows'])
used = used.decode('UTF-8')

for line in used.splitlines():
    if line == "*stats":
        os.system("eww close stats")
        os.system("eww close spotify-window")
    elif line == "stats":
        os.system("eww open stats")
        os.system("eww open spotify-window")
