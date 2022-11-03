#!/bin/bash

x_posi_y_posi_scale_width_scale_height_lib="${WIN_INPUT_GUI_LIB_DIR_PATH}/x_posi_y_posi_scale_width_scale_height_lib"
. "${x_posi_y_posi_scale_width_scale_height_lib}/resize_maxs.sh"
. "${x_posi_y_posi_scale_width_scale_height_lib}/judge_panel_position.sh"
. "${x_posi_y_posi_scale_width_scale_height_lib}/echo_true_resolution_list_source.sh"
unset -v x_posi_y_posi_scale_width_scale_height_lib


echo_x_posi_y_posi_scale_width_scale_height(){
	set +ux
	local ifs_old=${IFS}
	#パネルサイズ取得
	local WIN_DEPTH=0
	local IFS=$'\n' 
	#パネルの位置（左、上、下）にあわせて、現在の縦横サイズ計算
	local true_resolution_list_source=$(\
		echo_true_resolution_list_source \
			"${PANAL_WIDTH}" "${PANAL_HEIGHT}" \
			"${DISPLAY_RSOLUTION_WIDTH}" "${DISPLAY_RSOLUTION_HEIGHT}"\
	)
	local TRUE_DISPLAY_RESOLUTION_LIST=($(echo "${true_resolution_list_source}"))
	#パネルの座標を取得
	#index画面のウィンドウサイズと座標を決定
	case "${EXECUTE_COMMAND}" in 
		"")
			local scale_display_width="${CENTER_SCALE_DISPLAY_WIDTH}"
			local scale_display_height="${CENTER_SCALE_DISPLAY_HEIGHT}"
			local x_position=$(( (${TRUE_DISPLAY_RESOLUTION_LIST[0]} - ${scale_display_width}) / 2 ))
			local y_position=$(( (${TRUE_DISPLAY_RESOLUTION_LIST[1]} - ${scale_display_height}) ))
			;;
		*)
			local x_posi_y_posi_scale_width_scale_height_con=$(resize_max)
			local IFS=$',' 
			local x_posi_y_posi_scale_width_scale_height_list=(\
				$(\
					echo "${x_posi_y_posi_scale_width_scale_height_con}"\
				)\
			)
			local x_position="${x_posi_y_posi_scale_width_scale_height_list[0]}"
			local y_position="${x_posi_y_posi_scale_width_scale_height_list[1]}"
			local scale_display_width="${x_posi_y_posi_scale_width_scale_height_list[2]}"
			local scale_display_height="${x_posi_y_posi_scale_width_scale_height_list[3]}"
			local IFS="${ifs_old}"
		;;
	esac
	echo "${x_position},${y_position},${scale_display_width},${scale_display_height}"
}