#!/bin/bash


exit_when_app_mode(){
	case "${WINDOW_TITLE}" in
	"${CMDCLICK_WINDOW_TITLE}")
		;;
		*) exit 0
		;;
	esac
}