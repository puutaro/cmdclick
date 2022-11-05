#!/bin/bash


make_setting_con_by_use_key(){
	local setting_con_before_edit="${1}"
	local cmdclick_setting_key_con="${2}"
	echo "${setting_con_before_edit}" \
	| awk \
	-v cmdclick_setting_key_con="${cmdclick_setting_key_con}" \
	'function delete_processed_key(\
		current_key \
	){
		current_key_replace_success_bool \
			= sub(\
				"^"current_key"\n", \
				"\n", \
				cmdclick_setting_key_con \
			)
		if(current_key_replace_success_bool <= 0) {
			current_key_replace_success_bool \
				= sub(\
					"\n"current_key"\n", \
					"\n", \
					cmdclick_setting_key_con \
				)
		}
		if(current_key_replace_success_bool <= 0) {
			current_key_replace_success_bool \
				= sub(\
					"\n"current_key"$", \
					"", \
					cmdclick_setting_key_con \
				)
		}
	}
	BEGIN {
		setting_default_value_cons_of["'${CMDCLICK_INI_PASTE_AFTER_ENTER}'"]="'${PASTE_AFTER_ENTER_DEFAULT_CB_VALUE}'"
	}
	{
		current_key = substr($0, 0, index($0, "=")-1)
		if(!current_key) next
		current_value = substr($0, index($0, "=")+1, length($0))
		if(\
			cmdclick_setting_key_con !~ "^"current_key \
			&& cmdclick_setting_key_con !~ "\n"current_key \
		) next
		target_default_value = setting_default_value_cons_of[current_key]
		if(!target_default_value){
			delete_processed_key(\
				current_key \
			)
			printf "--field="current_key"\t"current_value"\t"
			next
		}
		success_bool = sub("^"current_value"!", "^"current_value"!", target_default_value)
		if(success_bool<=0) sub("!"current_value, "!^"current_value, target_default_value)
		delete_processed_key(\
				current_key \
		)
		printf "--field="current_key":CB\t"target_default_value"\t"
	}'
}