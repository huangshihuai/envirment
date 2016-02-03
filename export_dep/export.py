#!/usr/bin/python
#coding=utf-8

import os

msgError=[]

installPath=""
sourcePath=""
# 读取路径配置文件
def readPath(config):
    if os.path.exists(config) == False:
        print ("warn:配置文件没找到:" + config)
        exit()
    fp=open(config, 'r')
    listOfAll=fp.read().splitlines()
    for line in listOfAll:
        # 安装路径
        if "exportPath:" in line:
            tmp=line.split(':');
            if len(tmp) != 2:
                print "配置文件错误"
                exit()
            global installPath
            installPath=tmp[1]
            continue
        if "sourcePath:" in line:
            tmp=line.split(':');
            if len(tmp) != 2:
                print "配置文件错误"
                exit()
            global sourcePath
            sourcePath=tmp[1]
            continue
    fp.close()

readPath('./config/path_config')

# 获取绝对路径
installPath=os.path.abspath(installPath)
# 判断路径是否存在
if os.path.exists(installPath) == False:
    print "文件路径不存在:" + installPath
    exit()
# 获取绝对路径
sourcePath=os.path.abspath(sourcePath)

def exportZip(sourcePath, exportPath):
    os.system("unzip " + sourcePath + " -d " + exportPath)
    return

def exportGz(sourcePath, exportPath):
    os.system("tar -zxvf " + sourcePath + " -C " + exportPath)
    return

def exportBz(sourcePath, exportPath):
    os.system("tar -xjf " + sourcePath + " -C " + exportPath)
    return

def createLn(sourcePath, lnPath):
    os.system("ln -s " + sourcePath + " " + lnPath)
    return

defType={'.zip': exportZip, '.tar.gz': exportGz, '.tar.bz2': exportBz}

#读取配置文件
def readFile(config):
    if os.path.exists(config) == False:
        print ("warn:配置文件没找到:" + config)
        exit()
    f=open(config, 'r')
    for line in f:
        msg=[]
        msg=line.replace('\n', '').split('=')
        getType(msg)
    f.close()
    return

def getType(msg):
    if len(msg) != 3:
        print ("msg长度不为3")
        return
    fileName=msg[2]
    fileLn=msg[0]
    exportName=msg[1]
    for filetype in defType:
        if  filetype in fileName:
            os.chdir(sourcePath)
            if os.path.exists(sourcePath + "/" + fileName) == False:
                msgError.append('Not Fount' + sourcePath + "/" + fileName)
                print "源文件未找到: " + sourcePath + "/" + fileName
                return
            if os.path.exists(installPath + "/" + exportName) == True:
                os.system("sudo rm -rf " + installPath + "/" + exportName)
            if os.path.exists(installPath + "/" + fileLn) == True:
                os.system("sudo rm -rf " + installPath + "/" + fileLn);
            defType[filetype](sourcePath + "/" + fileName, installPath)
            os.chdir(installPath)
            createLn(exportName, fileLn)
            return
    return

config="./config/export_config"
readFile(config)
print "错误选项:"
for errItem in msgError:
    print errItem
