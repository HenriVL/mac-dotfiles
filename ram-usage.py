#!/bin/python3

import psutil
import sys

if sys.argv[1] == "percent":
    print( psutil.virtual_memory().percent )
else:
    print( round(psutil.virtual_memory().used/1024/1024/1024, 2) )
