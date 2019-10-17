#!/bin/sh

# diretory local to remote
LocalBackDir=/apps/sda1/gitlab/data/backups
#RemoteBackDir=/apps/var/gitlab/backup/docker-bak
RemoteBackDir=/apps/sda1/gitlab/data

# remote user and port
RemoteUser=root
RemotePort=22

# backup server list
RemoteIP=1.1.1.1

# 备份时间戳
Date=`date +"%F-%T"`

# 备份日志文件
LogFile=$LocalBackDir/log/backup_gitlab_remote_$Date.log
touch $LogFile


# backup file within a day
Backfile_Send_To_Remote1=`find $LocalBackDir -type f -mtime -1 -name '*.tar'`
Backfile_Send_To_Remote2=`find $LocalBackDir -type f -mtime -1 -name '*.tgz'`

# set up logfile
touch $LogFile

# 打印每次备份的档案名
echo "The files send to remote server is: $Backfile_Send_To_Remote1" >> $LogFile
echo "The files send to remote server is: $Backfile_Send_To_Remote2" >> $LogFile

# trans local backup file to remote server 
scp -P $RemotePort $Backfile_Send_To_Remote1 $RemoteUser@$RemoteIP:$RemoteBackDir
scp -P $RemotePort $Backfile_Send_To_Remote2 $RemoteUser@$RemoteIP:$RemoteBackDir

# 备份结果追加到备份日志
if [ $? -eq 0 ];then
  echo "--------------------------------Success!-------------------------------" >> $LogFile
  echo "Gitlab copy to remote server success at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogFile
else
  echo "--------------------------------Failed!----------------------------------" >> $LogFile
  echo "Gitlab copy to remote server fail at $(date +"%Y-%m-%d %H:%M:%S")" >> $LogFile
fi
