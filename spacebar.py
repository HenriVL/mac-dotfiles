#!/bin/python3

import pyautogui
from pynput import keyboard
import os
import time
import subprocess

def on_press(key):
    return True

def on_release(key):
    if pyautogui.position().x < 80 and key == keyboard.Key.space:
        active = subprocess.check_output(['xdotool', 'getwindowfocus', 'getwindowname'])
        active = active.decode('UTF-8')
        if active[:-1] != "Spotify":
            print("jow")
            os.system("playerctl --player=spotify play-pause")
            os.system("python3 ~/.config/eww/scripts/play-pause.py")
            time.sleep(0.1)


with keyboard.Listener(
    on_press=on_press,
    on_release=on_release) as listener:
   listener.join()
