#!/bin/python3

import subprocess

current = subprocess.check_output(['brightnessctl', 'g'])
current = int( current )

max_bright = subprocess.check_output(['brightnessctl', 'm'])
max_bright = int( max_bright )

print(round((current/max_bright)*100))
