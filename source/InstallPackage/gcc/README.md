gcc4.9的压缩方式:
    假设有gcc-4.9.0.tar.gz的文件,将打包压缩多个为10MB的文件
    tar cjf - gcc-4.9.0.tar.gz | split -b 10m - gcc-4.9.0.tar.bz2.

将多个gcc-5.9.0.tar.bz2.a* 解压,命令如下
    cat gcc-4.9.0.tar.bz2.a* | tar xj
