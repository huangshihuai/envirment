function checkFile() {
    if [ ! -f "$1" ]; then
        return 1
    fi
    return 0
}

function checkDir() {
    if [ ! -d "$1" ]; then
        return 1
    fi
    return 0
}

function checkStr() {
    if [ -z "$1" ]; then
        return 1
    fi
    return 0
}

function checkLn() {
    if [ ! -L "$1" ]; then
        return 1
    fi
    return 0
}

function exportUnzip() {
    # check pagePath
    checkFile "$1"
    if [ 0 -ne "$?" ]; then
        echo this pagePath:"$1" not fount
        exit
    fi
    local pagePath="$1"
    # unzip Path
    checkStr "$2"
    if [ 0 -ne "$?" ]; then
        echo 需要解压路径:"$2"
        exit
    fi
    unzip "$pagePath" -d "$2"
    if [ 0 -ne "$?" ]; then
        echo 解压失败...
        exit
    fi
}
