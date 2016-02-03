#!/usr/bin/python
#coding=utf-8

import os

exportPath=""

def readPath(config):
    if os.path.exists(config) == False:
        print "配置文件路径不存在: " + config
        exit()
    fp=open(config, 'r')
    listOfAll=fp.read().splitlines()
    for line in listOfAll:
        # 读取安装路径
        if "exportPath" in line:
            tmp=line.split(':')
            if len(tmp) != 2:
                print "配置文件错误"
                exit
            global exportPath
            exportPath=tmp[1]
            break;
    fp.close()

def readFile(config):
    f=open(config, 'r')
    for line in f:
        msg=[]
        msg=line.replace('\n', '').split('=')
        deleteFile(msg)
    f.close()
    return

def deleteFile(msg):
    if len(msg) != 3:
        print "warn: 配置文件错误"
        return
    exportName=msg[1]
    fileLn=msg[0]
    if os.path.exists(exportPath + "/" + exportName) == True:
        print "delete file/directory: " + exportPath + "/" + exportName
        os.system("sudo rm -rf " + exportPath + "/" + exportName)
    else:
        print "file/directory not fount: " + exportPath + "/" + exportName

    if os.path.islink(exportPath + "/" + fileLn) == True:
        print "delete file link: " + exportPath + "/" + fileLn
        os.system("sudo rm -rf " + exportPath + "/" + fileLn)
    else:
        print "file link not fount: " + exportPath + "/" + fileLn

config=""

readPath("./config/path_config")
exportPath=os.path.abspath(exportPath)
if os.path.exists(exportPath) == False:
    print ("文件路径没找到:" + exportPath)
    exit()
os.system("cd " + exportPath)
readFile("./config/export_config")
