#!/usr/bin/env python
# -*- coding: utf-8 -*-
from shutil import copyfile
import os

def createFile(fileName,ext,path):
    if os.path.exists(path +"/"+ fileName + ext):
        return "File already exists."
    else:
        try:
            copyfile("/usr/share/harbour-tide/qml/templates/template"+ext, path +"/"+ fileName + ext)
        except:
            raise
