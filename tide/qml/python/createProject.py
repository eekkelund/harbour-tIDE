#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import os, errno
from os.path import abspath
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
def copy(projectName, projectPath):
    try:
        copytree("/usr/share/harbour-tide/qml/template-app/", projectPath+"/"+projectName)
        rename_files(projectName, projectPath)
        rename_content(projectName, projectPath)
    except OSError as exc:
        if exc.errno == errno.ENOTDIR:
            shutil.copy("../../template-app/", projectPath+"/"+projectName)
        else:
            raise

def rename_files(projectName, projectPath):
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

def rename_content(projectName, projectPath):
    for root,dirs,files in os.walk(projectPath+"/"+projectName+"/"):
        for file in files:
            newlines = []
            try:
                if file.endswith("pyc"):
                    os.remove(os.path.join(root,file))
                elif file.endswith("pyo"):
                    os.remove(os.path.join(root,file))
                else:
                    with open(root+"/"+file, "r") as fi:
                        for i, line in enumerate(fi, 1):
                            newlines.append(line.replace("template", projectName))
                    with open(root+"/"+file, 'w') as fi:
                        for line in newlines:
                            fi.write(line)
            except UnicodeDecodeError:
                files.remove(file)
    return "success"
