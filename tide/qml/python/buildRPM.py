#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import os, shutil, tarfile, pty, sys
from select import select
from subprocess import PIPE, Popen, STDOUT
from threading import Thread
import signal

process =None
bgthread =None
buildP =None
project=None

def createBuildDir(projectName, buildPath, projectPath):
    try:
        if not os.path.exists(buildPath):
            os.makedirs(buildPath +"/BUILD")
            os.makedirs(buildPath +"/SOURCES")
            os.makedirs(buildPath +"/SPECS")
            os.makedirs(buildPath +"/BUILDROOT/")
        if os.path.exists(buildPath +"/"+ projectName):
            #create new
            shutil.rmtree(buildPath +"/"+ projectName)
        getReady(projectName, buildPath, projectPath)
    except:
        raise

def getReady(projectName, buildPath, projectPath):
    #cwd = os.getcwd()
    #pyotherside.send(cwd)
    with tarfile.open(projectName+"-0.1.tar.bz2", "w:bz2") as tar:
           tar.add(projectPath+"/"+ projectName, arcname=os.path.basename(projectPath+"/"+ projectName))
    shutil.move(projectName+"-0.1.tar.bz2", buildPath+"/SOURCES/"+projectName+"-0.1.tar.bz2")
    shutil.copy(projectPath+"/"+ projectName+"/rpm/"+projectName+".spec", buildPath+"/SPECS/"+projectName+".spec")
    global project
    global buildP
    project=projectName
    buildP =buildPath

def build():
    master_fd, slave_fd = pty.openpty()
    global process
    process = Popen(["rpmbuild", "-ba", buildP+"/SPECS/"+project+".spec"], stdin=slave_fd, stdout=slave_fd, stderr=STDOUT, bufsize=0, close_fds=True)
    pyotherside.send('pid', process.pid)
    timeout = .1
    with os.fdopen(master_fd, 'r+b', 0) as master:
        input_fds = [master, sys.stdin]
        while True:
            fds = select(input_fds, [], [], timeout)[0]
            if master in fds: # subprocess' output is ready
                data = os.read(master_fd, 512) # <-- doesn't block, may return less
                if not data: # EOF
                    input_fds.remove(master)
                else:
                    os.write(sys.stdout.fileno(), data) # copy to our stdout
                    pyotherside.send('output', {'out':data})
            if sys.stdin in fds: # got user input
                data = os.read(sys.stdin.fileno(), 512)
                if not data:
                    input_fds.remove(sys.stdin)
                else:
                    master.write(data) # copy it to subprocess' stdin
            if not fds: # timeout in select()
                if process.poll() is not None: # subprocess ended
                    # and no output is buffered <-- timeout + dead subprocess
                    assert not select([master], [], [], 0)[0] # race is possible
                    os.close(slave_fd) # subproces don't need it anymore
                    break
    rc = process.wait()
    pyotherside.send('pid', "subprocess exited with status %d" % rc)
    process.kill()

def init():
    global bgthread
    bgthread = Thread(target=build)
    return "create"

def start_proc():
    bgthread.start()
    return "started"

def kill():
    os.kill(process.pid, signal.SIGTERM)
    bgthread = None
    return "stopperd"
