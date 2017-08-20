#!/usr/bin/env python3
# coding: utf8

import sys

lines = sys.stdin.readlines()
lines[len(lines) - 1] = lines[len(lines) - 1].rstrip()
print(''.join(lines), end='')
