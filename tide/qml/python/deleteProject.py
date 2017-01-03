#!/usr/bin/env python
# -*- coding: utf-8 -*-
import pyotherside
import os
import shutil

def remove(projectPath, projectName):
    if os.path.exists(projectPath+"/"+projectName):
        try:
            shutil.rmtree(projectPath+"/"+projectName)
            return True
        except:
            return False
    else:
        return False
