#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from os import listdir, pardir
from os.path import isfile, join,abspath, exists
import glob
import pyotherside


def filess(projectPath, projectName):
    try:
        for path, dirs, files in os.walk(projectPath+'/' + projectName):
            for name in files:
                file_.append(os.path.join(path, name))

        filelist = [{'files': i} for i in file_]
        return filelist
    except:
        raise

def projects(path):
    projects=[]
    if not exists(path):
        return 0
    else:
        for f in listdir(path):
            projects.append({'project':f})
        return projects

def files(path):
    #onlyfiles=[f for f in listdir(projectPath+'/' + projectName) if isfile(join(projectPath+'/' + projectName, f))]
    all = []
    path= abspath(path)
    projectFolder = False;
    for i in glob.glob('/home/nemo/Projects/*'):
        if abspath(path) == i:
            projectFolder=True;
    if not projectFolder:
        all.append(join(pardir+"/"))
    for f in listdir(path):
        if not isfile(join(path, f)):
            f=f+"/"
        all.append(join(f))
    filelist =[]
    for name in all:
        filelist.append({'files':name, 'pathh':path+"/"+name})
    return filelist
