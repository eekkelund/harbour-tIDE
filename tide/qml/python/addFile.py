#!/usr/bin/env python
# -*- coding: utf-8 -*-
from shutil import copyfile
import os

def createFile(fileName,ext,path):
    if os.path.exists(path +"/"+ fileName + ext):
        return "File already exists."
    else:
        try:
            if os.path.exists("/usr/share/harbour-tide/qml/templates/template"+ext):
                copyfile("/usr/share/harbour-tide/qml/templates/template"+ext, path +"/"+ fileName + ext)
                return (path +"/"+ fileName + ext)
            else:
                file = open(path +"/"+ fileName + ext, 'a+', encoding = "utf-8")
                file.close()
                return (path +"/"+ fileName + ext)
        except:
            raise
