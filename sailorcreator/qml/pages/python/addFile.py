#!/usr/bin/env python
# -*- coding: utf-8 -*-
from shutil import copyfile
import os

def createFile(fileName,ext,path):
    if os.path.exists(path +"/"+ fileName + ext):
        return "File already exists."
    else:
        #if(ext == ".qml"):
        try:
            copyfile("/usr/share/harbour-sailorcreator/qml/templates/template"+ext, path +"/"+ fileName + ext)
            #return path + fileName + ext
                #file = open(path + fileName + ext, "w")
                #file.write
        except:
            raise
