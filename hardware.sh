#!/bin/bash
#测试所有硬盘读的速度并输出到文档
function disk_read   {
cd /dev
for d in $(ls|grep sd);
do
 echo "测试${d}的读速度" 
 echo "测试${d}的读速度" >> ~/hardware.out
 sudo hdparm -t /dev/${d} >> ~/hardware.out 
done
}
#测试写速度
function disk_write {
echo $2
if [ -d "$1" ];then
cd $1
echo "测试写速度"
echo "$2" 
echo "$2" >> ~/hardware.out
sudo time dd if=/dev/zero bs=1024 count=1000000 of=/1Gb.file >> ~/hardware.out 2>&1
fi
}

function chkError(){
	if [ $? != 0 ];then
         	echo $2
                exit 1
	fi
}
#检查输出文件是否存在
function chk_file () {
if [ -f ~/hardware.out ];then
 rm ~/hardware.out
fi
}

function hard_disk_info () {
echo "输出硬盘信息"
for d in  a b c d e f g h i j k l m n o p q r s t u v w ;
do
sudo  hdparm -i "/dev/sd${d}" >> ~/hardware.out 2> /dev/null
done
echo "输出完成"
}
function cpu_info {
echo " CPU信息" 
cat /proc/cpuinfo | grep "model name" | uniq |awk -F: '/model name/{printf $2}'
echo ""
}
chk_file
#disk_read 
#disk_write /data "测试阵列卡写速度"
#disk_write ~  "测试系统盘写速度"
#hard_disk_info 
cpu_info 
