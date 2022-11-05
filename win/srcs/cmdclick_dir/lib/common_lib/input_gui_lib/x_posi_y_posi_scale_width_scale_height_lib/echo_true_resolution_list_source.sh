#!/bin/bash

echo_true_resolution_list_source(){
	local panal_width=${1}
	local panal_height=${2}
	local display_rsolution_width=${3}
	local display_rsolution_height=${4}
	if [ ${panal_width} -gt 0 ]; then
		local true_display_resolution_width="${display_rsolution_width}"
		local true_display_resolution_height=$(\
			expr ${display_rsolution_height} - ${panal_height}\
		)
	else
		local true_display_resolution_width=$(\
			expr ${display_rsolution_width} - ${panal_width}\
		)
		local true_display_resolution_height="${display_rsolution_height}"
	fi
	echo "${true_display_resolution_width}" \
	 	| sed "$ a ${true_display_resolution_height}"
}