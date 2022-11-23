#!/bin/bash


surround_single_double_quote_when_existing_space_or_quote(){
	local ini_value_source="${1}"
	echo "${ini_value_source}" \
    | awk '
    function exec_surround(\
    	exist_target_char, \
    	surround_char \
    ){
    	double_quote_surround = \
			match($0, /^\x22.*\x22$/)
		if(double_quote_surround){ 
			print $0
			next
		}
		signle_quote_surround = \
			match($0, /^\x27.*\x27$/)
		if(signle_quote_surround){
			print $0
			next
		}
    	if(!exist_target_char) return
    	prefix_surrounded = match($0, "^"surround_char)
		if(prefix_surrounded) {
			print $0""surround_char
			next
		}
		suffix_surrounded = match($0, surround_char"$")
		if(suffix_surrounded){
			print surround_char""$0
			next
		}
		print surround_char""$0""surround_char
		next
    }
    {
		single_quote_middle_exist = match(\
			$0, /^([a-zA-z]|[^a-zA-Z]).*\x27.*([a-zA-z]|[^a-zA-Z])$/ \
		)
		if(\
			single_quote_middle_exist \
			&& double_quote_surround \
		) {
			print $0
			next
		}
		exec_surround(\
    		single_quote_middle_exist, \
    		"\x22" \
    	)

		double_quote_middle_exist = match(\
			$0, /^([a-zA-z]|[^a-zA-Z]).*\x22.*([a-zA-z]|[^a-zA-Z])$/ \
		)
		if(\
			double_quote_middle_exist \
			&& signle_quote_surround \
		) { 
			print $0
			next
		}
		exec_surround(\
    		double_quote_middle_exist, \
    		"\x27" \
    	)

		hankaku_space_exist = match($0, /\x20/)
		zenkaku_space_exist = match($0, /　/)
		space_exist = hankaku_space_exist + zenkaku_space_exist
		if(!space_exist) {
			print $0
			next
		}
		single_quote_exist = match(\
			$0, /\x27/ \
		)
		if(single_quote_exist) \
			exec_surround(\
	    		space_exist+1, \
	    		"\x27" \
	    	)
		exec_surround(\
    		space_exist+1, \
    		"\x22" \
    	)
    }' 
}