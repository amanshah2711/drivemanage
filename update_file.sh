#!/usr/bin/env python

from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive
import os

path = '/home/amanshah/Documents'
		

def findpath(start, name):
	for data in os.listdir(start):
		if os.path.isdir(start + '/' + data):
			hold =  findpath(start + '/' + data, name)
			if hold != None:
				return hold
		elif name == data:
			print('finally')


gauth = GoogleAuth()
gauth.LocalWebserverAuth()
drive = GoogleDrive(gauth)
file_list = drive.ListFile({'q': "'root' in parents and trashed=false"}).GetList()

for file1 in file_list:
  temp = file1['title']
  hold = findpath(path, temp)
  if hold != None:
	  file1.SetContentFile(hold)
	  file1.Upload()
