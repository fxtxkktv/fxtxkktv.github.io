#!/bin/bash
# + + + ++ + + ++ + + ++ + + ++ + + ++ + + ++ + + ++ + + ++ #
#        ┏┓　　　┏┓                                         # 
# 　　　┏┛┻━━━┛┻┓ + +                                       #
# 　　　┃　　　━　　　┃ ++ + + +                            #
# 　　 ████━████ ┃+                                         #
# 　　　┃　　　　　　 ┃ +                                   #
# 　　　┃　　　┻　　　┃                                     #
# 　　　┃　　　　　　 ┃ + +                                 #
# 　　　┗━┓　　　┏━┛                                        #
# 　　　　　┃　　　┃ + + + +                                #
# 　　　　　┃      ┃ +神兽保佑,代码无bug　　                #
# 　　　　　┃　　　┃　　+　　　　　　　　　                 #
# 　　　　　┃　 　　┗━━━┓ + +                               #
# 　　　　　┃ 　　　　　　　┣┓                              #
# 　　　　　┃ 　　　　　　　┏┛                              #
# 　　　　　┗┓┓┏━┳┓┏┛ + + + +                               #
# 　　　　　　┃┫┫　┃┫┫                                      #
# 　　　　　　┗┻┛　┗┻┛+ + + +                               #
# + + + ++ + + ++ + + ++ + + ++ + + ++ + + ++ + + ++ + + ++ #
echo -en "1. ==========>>>> 安装程序依赖包\n"
yum -y install wget git gcc mysql-server mysql-devel MySQL-python gnutls-utils epel-release 
if [[ $? = 0 ]];then
   true
else
   echo -en "\n程序依赖包安装失败,请检查网络或其他原因\n"
   exit 1
fi

echo -en "\n2. ==========>>>> 安装Python组件包\n"
relversion=$(rpm --eval "%{rhel}")
if [ -n "$(echo $relversion| sed -n "/^[0-9]\+$/p")" ] && [[ $relversion > 5 ]] ;then
   true
else
   echo -en "\n操作系统未正确识别或版本过低,请手动安装 https://github.com/fxtxkktv/fxtxkktv.github.io/files\n"
   exit 1
fi 
downurl="""https://raw.githubusercontent.com/fxtxkktv/fxtxkktv.github.io/master/files/RPM%E7%BB%84%E4%BB%B6%E5%8C%85/el${relversion}/Python27/Py27lnmos-2.7.16-6.el${relversion}.x86_64.rpm"""

wget -P /tmp $downurl
rpm -ivh /tmp/Py27lnmos-2.7.16-6.el${relversion}.x86_64.rpm --force
if [[ $? = 0 ]];then
   true
else
   echo -en "\nPython下载或安装失败,请手动下载 https://github.com/fxtxkktv/fxtxkktv.github.io/files\n"
   exit 1
fi

export PATH=$PATH:/opt/Py27lnmos/bin

wget -P /tmp https://bootstrap.pypa.io/get-pip.py
/opt/Py27lnmos/bin/python /tmp/get-pip.py 
/opt/Py27lnmos/bin/pip install virtualenv

if [[ $? = 0 ]];then
   true
else
   echo -en "\npip or virtualenv 下载或安装失败,请检查错误\n"
   exit 1
fi

rm -rf /tmp/Py27lnmos-2.7.16-6.el${relversion}.x86_64.rpm /tmp/get-pip.py
echo -en "\n3. ==========>>>> LnmOS 系统环境安装完成...\n"
exit 0
