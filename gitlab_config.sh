#!/bin/bash

# backup gitlab config
tar cfz /apps/sda1/gitlab/data/backups/config/$(date "+etc-gitlab-\%s.tgz") -C / apps/sda1/gitlab/etc

LocalBackDir=/apps/sda1/gitlab/data/backups

# 备份时间戳
Date=`date +"%F-%T"`

# 备份日志目录
LogDir=$LocalBackDir/log
[ -d $LogDir ] || mkdir -p $LogDir

# 新建日志文件
LogFile=$LocalBackDir/log/backup_gitlab_config_$Date.log
touch $LogFile

# 打印每次备份的档案名
echo "The files  backup to local server is:backup_gitlab_config_$Date" >> $LogFile

# $?符号显示上一条命令的返回值，如果为0则代表执行成功，其他表示失败
if [ $? -eq 0 ];then
#追加日志到日志文件
echo "--------------------------------Success!-------------------------------" >> $LogFile
echo "Gitlab config file auto backup at local server, end at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogFile

else

#追加日志到日志文件
echo "--------------------------------Failed!----------------------------------" >> $LogFile
echo "Gitlab config file auto backup at local server failed at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogFile
fi
