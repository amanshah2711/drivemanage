#!/usr/bin/env python

#Adding the necessary libraries to parse files, alter system files, and upload to drive
import argparse, os
from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive

#Parses for necessary arguments of filename and folder location within documents
parser = argparse.ArgumentParser()
parser.add_argument("-N","--name",required = True)
parser.add_argument("-P", "--path")
parser.add_argument("-F", "--filetype")
parser.add_argument("-T", "--template")

#Creates a dictionary of the inputs with the --___ corresponding to the key
args = vars(parser.parse_args())

if args['path'] == None:
	args['path']='Math'
#if args['filetype'] == None:
#	args['filetype'] = '.tex'
if args['template'] == None:
	args['template'] = '/home/amanshah/.vim/bundle/vim-latex/ftplugin/latex-suite/templates/homework.tex'
#File creation in the local system
filename = '/home/amanshah/Documents/{}'.format(args['path'])
filedir = '/home/amanshah/Documents/%s/%s' %(args['path'],args['name'])
if not os.path.exists(filedir):
	os.makedirs(filedir[:len(filedir) - 4])
	file_loc = filedir[:len(filedir) - 4] +'/' + args['name'] 
fil = open(file_loc, 'w+')
with fil as f:
	with open(args['template']) as f1:
		for line in f1:
			f.write(line)
		f1.close()
fil.close()
#Google Account Authorization using .json file in the same directory as this file
gauth = GoogleAuth()
gauth.LocalWebserverAuth()
drive = GoogleDrive(gauth)
#File Uploading to drive and content addition
uploaded = drive.CreateFile({'title': args['name']})
uploaded.SetContentFile(file_loc)
uploaded.Upload()
