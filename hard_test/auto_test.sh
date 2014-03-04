#!/bin/bash
#Program
# This program Automatic test hardware and output to hard_test.out
FILE_NAME="${pwd}hard_test.out"
rm -f hard_test.out 
function write_file {
tee -a $FILE_NAME
}

function test_hard_disk  {
sysbench --test=fileio --num-threads=16 --file-total-size=1000M --file-test-mode=rndrw prepare 

sysbench --test=fileio --num-threads=16 --file-total-size=1000M --file-test-mode=rndrw run | write_file
sysbench --test=fileio --num-threads=16 --file-total-size=1000M --file-test-mode=rndrw cleanup
echo '--------------------------------------'| write_file
}

echo 'test CPU'
sysbench --test=cpu --cpu-max-prime=20000 run | write_file
echo '--------------------------------------'| write_file

echo 'test threads'| write_file
sysbench --test=threads --num-threads=64 --thread-yields=100 --thread-locks=2 run | write_file
echo '--------------------------------------'| write_file

echo 'test system hard disk'| write_file
cd ~
test_hard_disk 

echo 'test raid '|write_file
cd /media/files
test_hard_disk

echo 'test memory'| write_file
sysbench --test=memory --num-threads=512 --memory-block-size=262144 --memory-total-size=32G run |write_file
echo '-------------------------------------------'|write_file

