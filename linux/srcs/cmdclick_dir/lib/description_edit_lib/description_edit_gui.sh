#!/bin/bash

description_edit_gui_lib_dir_path="${DESCRIPTION_EDIT_LIB_DIR_PATH}/description_edit_gui_lib"
. "${description_edit_gui_lib_dir_path}/display_description_edit.sh"
. "${description_edit_gui_lib_dir_path}/insert_labeling_section.sh"
. "${description_edit_gui_lib_dir_path}/remove_labeling_section.sh"
unset -v description_edit_gui_lib_dir_path


description_edit_gui(){
	local desctiption_edit_target_file_path="${1}"
	local ini_contents="$(cat "${desctiption_edit_target_file_path}")"
	local desctiption_before_edit=$(\
		echo_labeling_section_bitween_start_and_end \
			"${ini_contents}" \
			"print" \
	)
	local desctiption_after_edit=$(\
		display_description_edit \
			"${desctiption_before_edit}" \
	)
	case "${desctiption_after_edit}" in 
		"1") return ;;
		"") local inserted_labeling_section_ini_contents=$(\
				remove_labeling_section \
					"${ini_contents}" \
			);;
		*)
			local inserted_labeling_section_ini_contents=$(\
				insert_labeling_section \
					"${ini_contents}" \
					"${desctiption_after_edit}" \
			);; 
	esac
	confirm_edit_contensts \
		"${inserted_labeling_section_ini_contents}"
	echo "inserted_labeling_section_ini_contents ${inserted_labeling_section_ini_contents}"
	case "${CONFIRM}" in 
		"${OK_CODE}") ;;
		*) return 
	;; esac
	echo "${inserted_labeling_section_ini_contents}" \
		> "${desctiption_edit_target_file_path}"
	wait
	touch "${desctiption_edit_target_file_path}" &
}