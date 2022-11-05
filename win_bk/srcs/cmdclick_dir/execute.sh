#!/bin/bash


. ${LIB_DIR_PATH}/execute_lib/nw_ready_before_open_terminal.sh
. ${LIB_DIR_PATH}/execute_lib/handler.sh


LOOP=0
#シェルファイルから設定を読み込み
EXECUTE_FILE_PATH="${INI_FILE_DIR_PATH}/${EXECUTE_FILE_NAME}"
check_ini_file "${EXECUTE_FILE_PATH}"
exec_handler
# echo "BEFORE_EXECUTE setting_variable "
# echo "${EXECUTE_COMMAND}"
# echo "${EXEC_TERMINAL_ON}"
# echo "${EXEC_OPEN_WHERE}"
# echo "${EXEC_TERMINAL_SIZE}"
# echo "${EXEC_TERMINAL_FOCUS}"
# echo "${EXEC_INPUT_EXECUTE}"
# echo "${EXEC_IN_EXE_DFLT_VL}"
# echo "${EXEC_BEFORE_COMMAND}"
# echo "${EXEC_AFTER_COMMAND}"
# echo "${EXECUTE_FILE_PATH}"
#ターミナル起動コマンド格納
case "${EXEC_TERMINAL_ON}" in 
	"ON") 
		terminal_exec_command="cmd_click_startup_app ${CMD_CLICK_TARGET_APP} &"
		;;
	*) terminal_exec_command="" ;;
esac

#ターミナルリサイズコマンド格納
case "${EXEC_TERMINAL_SIZE}" in 
	"MAX")
		exec_terminal_size_command="maximize_app ${CMD_CLICK_TARGET_APP}" ;;
	"RMAX")
		exec_terminal_size_command="right_maximize_box ${CMD_CLICK_TARGET_APP}" ;;
	"LMAX")
		exec_terminal_size_command="left_maximize_box ${CMD_CLICK_TARGET_APP}" ;;
esac

#ターミナル使用時（デフォルト）
case "${EXEC_TERMINAL_ON}" in 
	"ON")
		# コマンド実行前の準備-------------------------------------
		# terminalを開く前の準備（サイズ、タブ、アクティブ化）
		case "${EXEC_OPEN_WHERE}" in 
			"NW") 
				"${terminal_exec_command}"
				wait;;
		esac

		# mac: 速度向上のためオミット(デフォルトでターミナル起動&リサイズ)
		# 対象のターミナルを起動し、リサイズ
		# 新しいタブで開く場合
		case "${EXEC_OPEN_WHERE}" in 
			"NT") 
				open_where_ntab_command="open_new_tab_cmc ${CMD_CLICK_TARGET_APP}"
				eval "${open_where_ntab_command}"
				wait;;
		esac
		#-----------------------------------------------------------------

		#以後、コマンド系----------------------------------------------------
		# #ディレクトリ移動
		#事前コマンド
		case "${EXEC_BEFORE_COMMAND}" in 
			"-"|"") ;;
			*) 
				EXECUTE_COMMAND="eval ${EXEC_BEFORE_COMMAND}; ${EXECUTE_COMMAND}";;
		esac
		#実行後コマンド
		case "${EXEC_AFTER_COMMAND}" in 
			"-"|"") ;;
			*) 
				EXECUTE_COMMAND="${EXECUTE_COMMAND}; eval ${EXEC_AFTER_COMMAND}"
		esac
		#実行コマンド（本体）
		execute_cmd_by_xdotool "${EXECUTE_COMMAND}" &
		;;
	"OFF")
		${EXECUTE_COMMAND} >/dev/null 2>&1 &
		;;
esac

SIGNAL_CODE=${INDEX_CODE}
