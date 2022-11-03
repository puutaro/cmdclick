#!/bin/bash

echo_valified_about_section_holder(){
	local ini_contents="${1}"
	echo "${ini_contents}" \
		| awk \
			-v ini_labeling_section_start_name="^${INI_LABELING_SECTION_START_NAME}\x24" \
			-v ini_labeling_section_end_name="^${INI_LABELING_SECTION_END_NAME}\x24" \
			-v ini_setting_section_start_name="^${INI_SETTING_SECTION_START_NAME}$" \
			-v ini_setting_section_end_name="^${INI_SETTING_SECTION_END_NAME}$" \
			-v ini_cmd_variable_section_start_name="^${INI_CMD_VARIABLE_SECTION_START_NAME}\x24" \
			-v ini_cmd_variable_section_end_name="^${INI_CMD_VARIABLE_SECTION_END_NAME}\x24" \
		'
		function print_err_message_by_judge_section_count(\
			count_section_start, \
			count_section_end, \
			err_message \
		){
			total_start_and_end = count_section_start + count_section_end
			if(\
				total_start_and_end != 0 \
				&& total_start_and_end != 2 \
			) printf "\x5C\x74\x5C\x74- "err_message"\x5C\x6E"
		}
		BEGIN {
			holder_name_list[0] = ini_labeling_section_start_name
			holder_name_list[1] = ini_labeling_section_end_name
			holder_name_list[2] = ini_setting_section_start_name
			holder_name_list[3] = ini_setting_section_end_name
			holder_name_list[4] = ini_cmd_variable_section_start_name
			holder_name_list[5] = ini_cmd_variable_section_end_name

			count_uniq_labeling_section_start = 0
			count_uniq_labeling_section_end = 0
			count_uniq_setting_section_start = 0
			count_uniq_setting_section_end = 0
			count_uniq_cmd_section_start = 0
			count_uniq_cmd_section_end = 0

			holder_order_num = 1
		}
		{
			if( $0 ~ ini_labeling_section_start_name ){
				count_uniq_labeling_section_start = 1
				holder_of[ini_labeling_section_start_name]++
				holder_order_of[ini_labeling_section_start_name] = holder_order_num
				holder_order_num++
			}
			if( $0 ~ ini_labeling_section_end_name ){
				count_uniq_labeling_section_end = 1
				holder_of[ini_labeling_section_end_name]++
				holder_order_of[ini_labeling_section_end_name] = holder_order_num
				holder_order_num++
			}
			if( $0 ~ ini_setting_section_start_name ){
				count_uniq_setting_section_start = 1
				holder_of[ini_setting_section_start_name]++
				holder_order_of[ini_setting_section_start_name] = holder_order_num++
			}
			if( $0 ~ ini_setting_section_end_name ){
				count_uniq_setting_section_end = 1
				holder_of[ini_setting_section_end_name]++
				holder_order_of[ini_setting_section_end_name] = holder_order_num
				holder_order_num++
			}
			if( $0 ~ ini_cmd_variable_section_start_name ){
				count_uniq_cmd_section_start = 1
				holder_of[ini_cmd_variable_section_start_name]++
				holder_order_of[ini_cmd_variable_section_start_name] = holder_order_num
				holder_order_num++
			}
			if( $0 ~ ini_cmd_variable_section_end_name ){
				count_uniq_cmd_section_end = 1
				holder_of[ini_cmd_variable_section_end_name]++
				holder_order_of[ini_cmd_variable_section_end_name] = holder_order_num
				holder_order_num++
			}
		}
		END {
			print_err_message_by_judge_section_count( \
				holder_of[ini_setting_section_start_name], \
				holder_of[ini_setting_section_end_name], \
				"SETTING_SECTION_HOLDER NUM ERR" \
			)
			print_err_message_by_judge_section_count( \
				count_uniq_setting_section_start, \
				count_uniq_setting_section_end, \
				"SETTING_SECTION_HOLDER CONBI ERR" \
			)
			print_err_message_by_judge_section_count( \
				holder_of[ini_cmd_variable_section_start_name], \
				holder_of[ini_cmd_variable_section_end_name], \
				"CMD_SECTION_HOLDER NUM ERR" \
			)
			print_err_message_by_judge_section_count( \
				count_uniq_cmd_section_start, \
				count_uniq_cmd_section_end, \
				"CMD_SECTION_HOLDER CONBI ERR" \
			)
			print_err_message_by_judge_section_count( \
				holder_of[ini_labeling_section_start_name], \
				holder_of[ini_labeling_section_end_name], \
				"LABELING_SECTION_HOLDER NUM ERR" \
			)
			print_err_message_by_judge_section_count( \
				count_uniq_labeling_section_start, \
				count_uniq_labeling_section_end, \
				"LABELING_SECTION_HOLDER CONBI ERR" \
			)
			insert_index=0
			for( i = 0; i < length(holder_name_list); i++ ){
				if(holder_order_of[holder_name] == 0) continue
				holder_name = holder_name_list[i]
				no_zero_holder_name_list[insert_index] = holder_name
				insert_index++
			}
			if( length(no_zero_holder_name_list) <= 1 ) exit
			check_roop_num = length(no_zero_holder_name_list) - 1
			for( i = 0; i < check_roop_num; i++ ){
				no_zero_holder_name = no_zero_holder_name_list[i]
				next_no_zero_holder_name = no_zero_holder_name_list[i+1]
				if(\
					holder_order_of[no_zero_holder_name] \
						< holder_order_of[next_no_zero_holder_name] \
				) continue 
				printf "\x5C\x74\x5C\x74- HOLDER ORDER ERR\x5C\x6E"
				printf "\x5C\x74\x5C\x74\x5C\x74- (about" no_zero_holder_name", "next_no_zero_holder_name")\x5C\x6E"
			}
		}
		'
}