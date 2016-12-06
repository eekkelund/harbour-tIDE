#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import configparser
import os

dataPath=None

def setDataPath(path):
    confPath = path+"/harbour-tide.conf"
    if not os.path.exists(confPath):
        os.makedirs(path)
        config = configparser.RawConfigParser()
        config['editor']={'darktheme': 'true',
                          'fontsize': '35',
                          'fonttype': "Sail Sans Pro Light",
                          'linenums': 'true',
                          'autosave': 'false',
                          'indentsize': '4',
                          'textcolor':"#cfbfad",
                          'qmlcolor':"#ff8bff",
                          'keycolor':"#808bed",
                          'propertiescolor':"#ff5555",
                          'jscolor':"#8888ff",
                          'strcolor':"#ffcd8b",
                          'commentcolor':"#cd8b00",
                          'bgcolor':"#1e1e27",
                          'trace':'false'
                          }
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
    config = configparser.RawConfigParser()
    if(dataPath!=None):
        config.read(dataPath)
        result = config['editor'][key]
        return result
