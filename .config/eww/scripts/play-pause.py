#!/bin/python3

import subprocess
import os

try:
    status = subprocess.check_output(['playerctl', '--player=spotify', 'status'])
    status = status.decode('UTF-8')

    if status[1] == "l":
        status = ""
    else:
        status = "契"

    os.system("eww -c ~/.config/eww update play-pause=\""+status+"\"")
except:
    os.system("eww -c ~/.config/eww update play-pause=\"契\"")
