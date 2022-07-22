#!/bin/python3

import subprocess
import os
import time


current = subprocess.check_output(['playerctl', '--player=spotify', 'position', '--format', '{{duration(position)}}'])
current = current.decode('UTF-8')
current = current[:-1]
ftr = [60,1]
current = sum([a*b for a,b in zip(ftr, map(int,current.split(':')))])

length = subprocess.check_output(['playerctl', '--player=spotify', 'metadata', '--format', '{{duration(mpris:length)}}'])
length = length.decode('UTF-8')
length = length[:-1]
length = sum([a*b for a,b in zip(ftr, map(int,length.split(':')))])

print(round((current/length)*100,2))
