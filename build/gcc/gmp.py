#coding=utf-8

import ConfigParser
import string
import sys
import os

class projectBuild:
    def __init__(self,configPath,):
        print('I\m projectBuild')

pb=projectBuild()

configPath="./config/gcc.ini"
#检查配置文件是否存在，存在返回True，不存在返回false
def configExists(configPath):
    if os.path.exists(configPath) == True:
        return os.path.abspath(configPath)
    else:
        print 'this config path not fount: ' + configPath
        exit()


configPath=configExists(configPath)
'''
print os.getcwd()
print os.path.abspath(os.getcwd() + '/../source/gcc')
if os.path.exists('./config/gcc1.ini') == True:
    print "2222"
else:
    exit()
config_ini="./config/gcc.ini"
cf=ConfigParser.ConfigParser()
cf.read('./config/gcc1.ini')

secs=cf.sections()
print secs

opts=cf.options('gcc')
print opts

kv=cf.items('gcc')
print kv


print cf.get('gcc', 'sources')
print cf.get('gcc', 'install')
'''
