#!/bin/python3

import subprocess
import io
import sys
import os
import json

current = subprocess.check_output(['xdotool', 'get_desktop'])
current = int( current )

used = subprocess.check_output(['wmctrl', '-l'])
used = used.decode('UTF-8')

buttons = [
    "(button :onclick \'wmctrl -s 0 && ./scripts/workspace.py\' :class \'",
    "(button :onclick \'wmctrl -s 1 && ./scripts/workspace.py\' :class \'",
    "(button :onclick \'wmctrl -s 2 && ./scripts/workspace.py\' :class \'",
    "(button :onclick \'wmctrl -s 3 && ./scripts/workspace.py\' :class \'",
    "(button :onclick \'wmctrl -s 4 && ./scripts/workspace.py\' :class \'",
    "(button :onclick \'wmctrl -s 5 && ./scripts/workspace.py\' :class \'"]

workspaces = ["workspace_inactive","workspace_inactive","workspace_inactive","workspace_inactive","workspace_inactive","workspace_inactive"]

for line in used.splitlines():
    temp = line[12:]
    temp = int( temp[0] )
    if temp > 6:
        break
    workspaces[temp] = "workspace_active"

workspaces[current] = "workspace_current"

for i in range(6):
    workspaces[i] = buttons[i] + workspaces[i] + "\')"

print("(box :class 'workspace' :valign 'center' :orientation 'v' :spacing 30 " + workspaces[0] + workspaces[1] + workspaces[2] + workspaces[3] + workspaces[4] + workspaces[5] + ')')
