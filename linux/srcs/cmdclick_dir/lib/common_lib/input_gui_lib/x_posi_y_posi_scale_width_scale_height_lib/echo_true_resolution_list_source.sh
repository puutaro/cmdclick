#!/bin/bash

echo_true_resolution_list_source(){
	# local panal_width=${1}
	# local panal_height=${2}
	# local display_rsolution_width=${3}
	# local display_rsolution_height=${4}
	local display_rsolution_width=${1}
	local display_rsolution_height=${2}
	local offset=60
	# if [ ${panal_width} -ge ${panal_height} ]; then
	# 	local true_display_resolution_width="${display_rsolution_width}"
	# 	local true_display_resolution_height=$(\
	# 		expr ${display_rsolution_height} - ${panal_height}\
	# 	)
	# else
	# 	local true_display_resolution_width=$(\
	# 		expr ${display_rsolution_width} - ${panal_width}\
	# 	)
	# 	local true_display_resolution_height="${display_rsolution_height}"
	# fi
	local true_display_resolution_width=$(\
			expr ${display_rsolution_width} - ${offset}\
		)
	local true_display_resolution_height=$(\
			expr ${display_rsolution_height} - ${offset}\
		)
	echo "${true_display_resolution_width}" \
	 	| sed "$ a ${true_display_resolution_height}"
}