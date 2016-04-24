import os
#coding=utf-8
# 存储shell的名字
shName=[
        'sys_php.sh',
        'zlib.sh',
        'mcrypt.sh',
        'jpeg.sh',
        'png.sh',
        'freetype.sh',
        'openssl.sh',
        't1lib.sh',
        'tiff.sh',
        'curl.sh',
        'xml.sh'
        ]
# shell 地址
shPath=os.path.abspath("./library/")
if os.path.exists(shPath) == False:
    print "shell 脚本目录不存在: " + shPath
    exit()

os.chdir(shPath)

def getShName(shellName):
    for name in shellName:
        if os.path.exists(shPath + "/" + name) == False:
            print "this shell not fount: " + shPath + "/" + name
            continue
        os.system("sh " + shPath + "/" + name)
    return

getShName(shName)
