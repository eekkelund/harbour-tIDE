#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import configparser
import os

dataPath=None
editorDefaults={'darktheme': 'True',
'fontsize': '35',
'fonttype': "Sail Sans Pro Light",
'linenums': 'True',
'autosave': 'True',
'indentsize': '4',
'textcolor':"#cfbfad",
'qmlcolor':"#ff8bff",
'keycolor':"#808bed",
'propertiescolor':"#ff5555",
'jscolor':"#8888ff",
'strcolor':"#ffcd8b",
'commentcolor':"#cd8b00",
'bgcolor':"#1e1e27",
'trace':'False',
'hint':'0',
'plugins':'False',
'wrapmode': 3,
'tabsize': '4',
}

def setDataPath(path):
    confPath = path+"/harbour-tide.conf"
    if not os.path.exists(path):
        os.makedirs(path)
    if not os.path.exists(confPath):
        config = configparser.RawConfigParser()
        config['editor']=editorDefaults
        with open(confPath, 'a+') as cfg:
            config.write(cfg)
    global dataPath
    dataPath = confPath
    return "path added"


def set(key, value):
    config = configparser.RawConfigParser()
    if(dataPath!=None):
        #Updating configuration file '.conf'
        config.read(dataPath)
        config.set('editor', key, value)
        with open(dataPath, 'w+') as configfile:
            config.write(configfile)

def get(key):
    config = configparser.RawConfigParser(defaults = editorDefaults)
    if(dataPath!=None):
        config.read(dataPath)
        if not config.has_option('editor',key):
            config.set('editor', key, default)
        result = config['editor'][key]
        return result

#conf files should be in same place. have to rewrite...
def setTab(key, value):
    path = "/var/lib/harbour-tide-keyboard/config/config.conf"
    config = configparser.RawConfigParser()
    if(path!=None):
        #Updating configuration file '.conf'
        config.read(path)
        config.set('General', key, value)
        with open(path, 'w+') as configfile:
            config.write(configfile)

def getTab(key):
    path = "/var/lib/harbour-tide-keyboard/config/config.conf"
    config = configparser.RawConfigParser()
    if(path!=None):
        config.read(path)
        if not config.has_option('General',key):
            config.set('General', key, 4)
        result = config['General'][key]
        return result
