#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import configparser
import os

def openings(filepath):
    if os.path.exists(filepath+"~"):
        file = open(filepath+"~", 'r')
    else:
        file = open(filepath, 'r')
    txt = file.read()
    file.close()
    return txt



def savings(filepath, text):
    if os.path.exists(filepath+"~"):
        os.remove(filepath+"~")
    file = open(filepath, 'w')
    file.write(text)
    file.close()
    return

def changeFiletype(filetype):
    config = configparser.RawConfigParser()
    config.read("/var/lib/harbour-sailorcreator-keyboard/config/config.conf")
    config.set('fileType', 'type', filetype)
    # Updating configuration file 'config.conf'
    with open("/var/lib/harbour-sailorcreator-keyboard/config/config.conf", 'w+') as configfile:
        config.write(configfile)

def autosave(filepath, text):
    file = open(filepath+"~", 'w')
    file.write(text)
    file.close()
    return



#pyotherside.atexit(files.saving)
