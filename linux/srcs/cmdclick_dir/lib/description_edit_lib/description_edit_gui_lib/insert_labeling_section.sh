#!/bin/bash


insert_labeling_section(){
	local ini_contents="${1}"
	local desctiption_after_edit="${2}"
	awk \
	    -v ini_contents="${ini_contents}" \
	    -v desctiption_after_edit="${desctiption_after_edit}" \
		-v INI_LABELING_SECTION_START_NAME="${INI_LABELING_SECTION_START_NAME}" \
	    -v INI_LABELING_SECTION_END_NAME="${INI_LABELING_SECTION_END_NAME}" \
		'
		BEGIN {
			gsub(/^ */, "", desctiption_after_edit)
			gsub(/\n */, "\n", desctiption_after_edit)
			gsub(/ *\n/, "\n", desctiption_after_edit)
			gsub(/ *$/, "", desctiption_after_edit)
			gsub(/\n/, "\n# ", desctiption_after_edit)
			labeling_start_order = index(ini_contents, INI_LABELING_SECTION_START_NAME)
			labeling_end_order = index(ini_contents, INI_LABELING_SECTION_END_NAME)
			if(\
				labeling_start_order > 0 \
				&& labeling_end_order > 0 \
			 ) {
			 	con_before_labeling=substr(ini_contents, 0, labeling_start_order-1)
			 	con_after_labeling=substr( \
			 		ini_contents, \
			 		labeling_end_order + length(INI_LABELING_SECTION_END_NAME), \
			 		length(ini_contents) \
			 	)
			 	print con_before_labeling \
			 		"" \
			 		INI_LABELING_SECTION_START_NAME \
			 		"" \
			 		desctiption_after_edit \
			 		"\n" \
			 		INI_LABELING_SECTION_END_NAME \
			 		con_after_labeling
			 	exit
			 }
			sub(\
				"\n", \
				"\n\n\n"\
					INI_LABELING_SECTION_START_NAME \
					desctiption_after_edit \
					"\n" \
					INI_LABELING_SECTION_END_NAME \
					"\n", \
				ini_contents \
			)
			print ini_contents
		}
		'
}