#!/bin/bash
#测试所有硬盘读的速度并输出到文档
CURRENT_DIR="${PWD}"

function dividing_line {
echo "----------------------------" >> "${CURRENT_DIR}"/hardware.out
}

function disk_read   {
dividing_line
cd /dev
for d in $(ls|grep sd);
do
 echo "测试${d}的读速度" 
 echo "测试${d}的读速度" >> "${CURRENT_DIR}"/hardware.out
 sudo hdparm -t /dev/${d} >> "${CURRENT_DIR}"/hardware.out 
done
dividing_line
}
#测试写速度
function disk_write {
dividing_line
echo $2
if [ -d "$1" ];then
cd $1
echo "测试写速度"
echo "$2" 
echo "$2" >> "${CURRENT_DIR}"/hardware.out
sudo time dd if=/dev/zero bs=1024 count=1000000 of=/1Gb.file >> "${CURRENT_DIR}"/hardware.out 2>&1
fi
dividing_line
}

function chkError(){
	if [ $? != 0 ];then
         	echo $2
                exit 1
	fi
}
#检查输出文件是否存在
function chk_file () {
if [ -f "${CURRENT_DIR}"/hardware.out ];then
 rm "${CURRENT_DIR}"/hardware.out
fi
}

function hard_disk_info () {
dividing_line
echo "输出硬盘信息"
for d in  a b c d e f g h i j k l m n o p q r s t u v w ;
do
sudo  hdparm -i "/dev/sd${d}" >>  "${CURRENT_DIR}"/hardware.out 2> /dev/null
done
echo "输出完成"
dividing_line
}

function cpu_info {
dividing_line
echo " CPU信息" >> "${CURRENT_DIR}"/hardware.out
cat /proc/cpuinfo | grep "model name" | uniq |awk -F: '/model name/{printf $2}' >> "${CURRENT_DIR}"/hardware.out
dividing_line
}
chk_file    
disk_read   
disk_write /data "测试阵列卡写速度"   
disk_write ~  "测试系统盘写速度"   
hard_disk_info   
cpu_info   
dividing_line 
