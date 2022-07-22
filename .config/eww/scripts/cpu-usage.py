#!/bin/python3

import psutil

print( psutil.cpu_percent(interval=0.5) )
