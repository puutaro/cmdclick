#!/bin/bash


remove_labeling_section(){
	local ini_contents="${1}"
	awk \
		-v ini_contents="${ini_contents}" \
		-v start_section_name="${INI_LABELING_SECTION_START_NAME}" \
		-v end_section_name="${INI_LABELING_SECTION_END_NAME}" \
		'
		BEGIN {
			exist_start_section_name = index(ini_contents, "\n"start_section_name)
			if(exist_start_section_name <= 0){
				print ini_contents
				exit
			}
			sub("\n *\n *\n"start_section_name, "\n"start_section_name,  ini_contents)
			sub(end_section_name"\n *\n", end_section_name"\n",  ini_contents)
			sub_num = sub(start_section_name".*"end_section_name, "", ini_contents)
			print ini_contents
		}
		'
}