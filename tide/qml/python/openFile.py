#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from os import listdir, pardir
from os.path import isfile, join,abspath, exists, expanduser
import glob
import pyotherside

def projects(path):
    projects=[]
    if not exists(path):
        return 0
    else:
        for f in listdir(path):
            projects.append({'project':f})
        projects = sorted(projects, key=lambda k: k['project'])
        return projects

def files(path):
    all = []
    path= abspath(path)
    projectFolder = False;
    for i in glob.glob(expanduser('~')+'/tIDE/Projects/*'):
        if abspath(path) == i:
            projectFolder=True;
    if not projectFolder:
        all.append(join(pardir+"/"))
    for f in listdir(path):
        if not isfile(join(path, f)):
            f=f+"/"
        if not f.endswith("~"):
            all.append(join(f))
    filelist =[]
    for name in all:
        filelist.append({'files':name, 'pathh':path+"/"+name})
    filelist = sorted(filelist, key=lambda k: k['files'])
    return filelist

def allfiles(path):
    all = []
    path= abspath(path)
    all.append(join(pardir+"/"))
    for f in listdir(path):
        if not isfile(join(path, f)):
            f=f+"/"
        if not f.endswith("~"):
            all.append(join(f))
    filelist =[]
    for name in all:
        filelist.append({'files':name, 'pathh':path+"/"+name})
    filelist = sorted(filelist, key=lambda k: k['files'])
    return filelist
