#!/bin/bash

# backup gitlab config
find  /apps/sda1/gitlab/data -name "*_11.4.5_gitlab_backup.tar" -mtime +3 -exec rm -rf {} \;
find  /apps/sda1/gitlab/data -name "etc-gitlab*.tgz" -mtime +3 -exec rm -rf {} \;

LocalBackDir=/apps/sda1/gitlab/data

## backup date
Date=`date +"%F-%T"`

# backup file within a day
Backfile_Remote_Server=`find $LocalBackDir -name "*_11.4.5_gitlab_backup.tar" -mtime +3`

# 备份日志目录
LogDir=$LocalBackDir/log
[ -d $LogDir ] || mkdir -p $LogDir

# 新建日志文件
LogFile=$LocalBackDir/log/backup_gitlab_config_$Date.log
touch $LogFile
echo "The files delete in server is: $Backfile_Remote_Server" >> $LogFile


# $?符号显示上一条命令的返回值，如果为0则代表执行成功，其他表示失败
if [ $? -eq 0 ];then
  echo "--------------------------------Success!-------------------------------" >> $LogFile
  echo "Gitlab delete in server success at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogFile
else
  echo "--------------------------------Failed!----------------------------------" >> $LogFile
  echo "Gitlab delete in server fail at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogFile
fi
