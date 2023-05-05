# -*- coding: utf-8 -*-
import os
import time

# 递归函数，用于删除指定文件夹及其子文件夹中的所有文件
def delete_files(folder_path):
    for root, dirs, files in os.walk(folder_path):
        for file_name in files:
            file_path = os.path.join(root, file_name)
            # print file_path
            os.remove(file_path)
            print '已删除文件：' + file_path

# 指定文件夹路径
folder_path = "/afs/cern.ch/user/z/zhenxuan/CMSSW_10_6_25/src/log"

# 不断循环执行
while True:
    # 删除指定文件夹及其子文件夹中的所有文件
    delete_files(folder_path)
    print '已删除所有文件'

    # 等待一段时间后再次执行
    time.sleep(60)  # 等待10秒钟后再次执行
