#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside

def openings(filepath):
    file = open(filepath, 'r')
    txt = file.read()
    file.close()
    return txt



def savings(filepath, text):
    file = open(filepath, 'w')
    file.write(text)
    file.close()
    return




#pyotherside.atexit(files.saving)
