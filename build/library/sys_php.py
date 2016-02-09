import os
import string
#coding=utf-8

if os.path.exists('../config/sys_php.ini') == False:
    print 'sys_php.ini not fount. check dir:buildRoot/build/config'
    exit()

rootPath=os.path.abspath('../../')
config=os.path.abspath('../config/sys_php.ini')

readConfig=['sources', 'pagelst']
cf=ConfigParser.ConfigParser()
cf.read(config)

opts=cf.options('info')

for item in readConfig:
    if item in opts
        continue
    print '请检查配置文件'
    exit()


function checkSource() {
    local sources=`cat "$config" | grep sources`
    local sources=`echo "$sources" | cut -d ':' -f 2`
    if [ -z "$sources" ]; then
        echo 'this config is null'
        exit
    fi
    local dependSource="$localPath""$sources"
    if [ ! -d $dependSource ]; then
        echo "dir not fount: $dependSource";
        exit
    fi
    File=$(cd $dependSource; pwd)
}

function installProduct() {
    local install=`cat "$config" | grep install`
    local install=`echo "$install" | cut -d ':' -f 2`
    local dependInstall="$localPath""$install"
    if [ ! -d $dependInstall ]; then
        echo "dir not fount: $dependInstall";
        exit
    fi
    Install=$(cd "$dependInstall"; pwd)
}

function getPage() {
    # 获取需要默认安装的软件包
    local page=`cat "$config" | grep page`
    page=`echo "$page" | cut -d ':' -f 2`
    checkStrIsNull "$page"
    local oldIFS=$IFS
    IFS=","
    local arrPage=($page)
    IFS=$oldIFS
    for page in ${arrPage[@]};do
        if [ ! -d "$File/$page" ]; then
            echo "this $File/$page not fount"
            continue
        fi
        echo "install page: $page"
        makeInstall "$File/$page"
    done
}

function makeInstall() {
    checkDir "$1"
    cd $1
    if [ -d "$page-build" ]; then
        sudo rm -rf "$page-build"
    fi
    mkdir "$page-build" && cd "$page-build"
    if [ -f "Makefile" ]; then
        sudo make clean > /dev/null 2>&1
        sudo rm "Makefile" > /dev/null 2>&1
    fi
    ../configure > /dev/null 2>&1
    if [ "$?" != "0" ]; then
        echo "configure error,this page:$page"
        return
    fi
    sudo make clean > /dev/null 2>&1
    make > /dev/null 2>&1
    if [ "$?" != "0" ]; then
        echo "make error, this page:$page"
        return;
    fi
    sudo make install >/dev/null 2>&1
    if [ "$?" != "0" ]; then
        echo "make install error, this page:$page"
        return
    fi
 }

checkSource
getPage
echo "install OK"
