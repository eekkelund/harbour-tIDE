#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import configparser

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

def changeFiletype(filetype):
    config = configparser.RawConfigParser()
    config.read("/var/lib/harbour-sailorcreator-keyboard/config/config.conf")
    config.set('fileType', 'type', filetype)
    # Writing our configuration file to 'config.conf'
    with open("/var/lib/harbour-sailorcreator-keyboard/config/config.conf", 'w+') as configfile:
        config.write(configfile)


#pyotherside.atexit(files.saving)
