import os
#coding=utf-8
# 存储shell的名字,按照依赖顺序变异
shName=[
        'gmp.sh',
        'mpfr.sh',
        'mpc.sh',
        'gcc.sh'
        ]
# shell 地址
gccPath=os.path.abspath("./gcc")
if os.path.exists(gccPath) == False:
    print "shell 脚本目录不存在: " + gccPath
    exit()

os.chdir(gccPath)

def getGccName(shellName):
    for name in shellName:
        if os.path.exists(gccPath + "/" + name) == False:
            print "this shell not fount: " + gccPath + "/" + name
            continue
        os.system("sh " + gccPath + "/" + name + " 0")
    return

print "this build long time"
getGccName(shName)
