#!/usr/bin/env python3

import sys

print (sys.stdin.read().encode().decode('unicode_escape'))
#rawString = sys.stdin.read()
#rawString = rawString.encode().decode('unicode_escape')
#print (rawString)
