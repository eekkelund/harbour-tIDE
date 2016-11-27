#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import configparser
import os

def openings(filepath):
    file = open(filepath, 'r', encoding = "utf-8")
    txt = file.read()
    file.close()
    return{'text': txt, 'fileTitle': os.path.basename(filepath)}

def openAutoSaved(filepath):
    file = open(filepath+"~", 'r', encoding = "utf-8")
    txt = file.read()
    file.close()
    return{'text': txt, 'fileTitle': os.path.basename(filepath+"~")}

def checkAutoSaved(filepath):
    if os.path.exists(filepath+"~"):
        return True
    else:
        return False

def savings(filepath, text):
    if os.path.exists(filepath+"~"):
        os.remove(filepath+"~")
    file = open(filepath, 'w', encoding = "utf-8")
    file.write(text)
    file.close()
    return os.path.basename(filepath)

def changeFiletype(filetype):
    config = configparser.RawConfigParser()
    config.read("/var/lib/harbour-sailorcreator-keyboard/config/config.conf")
    config.set('fileType', 'type', filetype)
    # Updating configuration file 'config.conf'
    with open("/var/lib/harbour-sailorcreator-keyboard/config/config.conf", 'w+') as configfile:
        config.write(configfile)

def autosave(filepath, text):
    if(filepath.endswith("~")):
        file = open(filepath, 'w', encoding = "utf-8")
    else:
        file = open(filepath+"~", 'w', encoding = "utf-8")
    file.write(text)
    file.close()
    return os.path.basename(filepath+"~")


