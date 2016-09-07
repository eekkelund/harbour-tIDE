#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import os, errno
from shutil import copyfile, copytree

def create(projectName, projectPath):

    try:
        if not os.path.exists(projectPath):
            os.mkdir(projectPath)

        if os.path.exists(projectPath +"/"+ projectName):
            return False

        else:
            copy(projectName, projectPath)
    except:
        raise



                #                  copyfile("../template-app/template.desktop",
                #                    projectPath+"/"+projectName+"/"+projectName+".desktop")
def copy(projectName, projectPath):
    try:
        copytree("/usr/share/harbour-qmlcreator/qml/template-app/", projectPath+"/"+projectName)
        rename(projectName, projectPath)
    except OSError as exc:
        if exc.errno == errno.ENOTDIR:
            shutil.copy("../../template-app/", projectPath+"/"+projectName)
        else:
            raise

def rename(projectName, projectPath):
    for root,dirs,files in os.walk(projectPath+"/"+projectName+"/"):
        if "pages" in dirs:
            dirs.remove("pages")
        elif "CoverPage.qml" in files:
            files.remove("CoverPage.qml")

        for filename in files:
            parts = filename.split(".")
            newName = projectName+".{}".format(parts[1])
            os.rename(os.path.join(root, filename),os.path.join(root,newName))
    return "success"

