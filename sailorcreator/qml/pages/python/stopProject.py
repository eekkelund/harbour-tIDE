#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import os, pty, sys
from select import select
from subprocess import PIPE, Popen, STDOUT
from threading import Thread
import signal


project =None
process =None
bgthread =None
def set_path(project_path):
    global project
    project = project_path
    return "path added"

def run_process():
    master_fd, slave_fd = pty.openpty()
    global process
    process = Popen(["qmlscene", project], stdin=slave_fd, stdout=slave_fd, stderr=STDOUT, bufsize=0, close_fds=True)
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
    print("subprocess exited with status %d" % rc)
    processs.kill()


#class Process():
#    def __init__(self):
def init():
    global bgthread
    bgthread = Thread(target=run_process)
    return "created"


def start_proc():
    bgthread.start()
    return "started"


def kill():
    #os.killpg(os.getpgid(process.pid), signal.SIGTERM)
    os.kill(process.pid, signal.SIGTERM)
    bgthread = None
    return "stopperd"



            #with Popen(["qmlscene", project],stdout=PIPE, stderr=STDOUT,bufsize=1) as p:
            #    for line in iter(p.stdout.readline, b''):

            #        pyotherside.send('output', {'out':line})
            #    p.communicate()


            #result = Popen(["qmlscene", project], stdout=PIPE, stderr=STDOUT)
            #while True:
            #    output = result.stdout.readline()
                #pyotherside.send('output', {'outLine':"asd"})
                #print(output.strip())
                #sys.stdout.flush()
            #    if output == '' and result.poll() is not None:
            #        break
            #    if output:
            #        pyotherside.send('output', {'outLine':output.strip()})
            #        print(output.strip())
                    #sys.stdout.flush()
            #rc = result.poll()
            #return rc
           #stdout = result.communicate()[0]

#processs = Process()
pyotherside.atexit(kill)
