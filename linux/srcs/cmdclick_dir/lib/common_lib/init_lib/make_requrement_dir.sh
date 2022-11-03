#!/bin/bash


make_requrement_dir(){
	if [ ! -d ${CMDCLICK_CONF_DIR_PATH} ]; then mkdir -p ${CMDCLICK_CONF_DIR_PATH}; fi
	if [ ! -d ${CMDCLICK_APP_DIR_PATH} ]; then mkdir -p ${CMDCLICK_APP_DIR_PATH}; fi
	# iniファイル格納用ディレクトリがなければ作成
	if [ ! -d ${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH} ];then mkdir -p ${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH};fi 
}