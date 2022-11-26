#!/bin/bash


surround_single_double_quote_when_existing_space_or_quote(){
	local ini_value_source="${1}"
	echo "${ini_value_source}" \
    | awk \
    -v next_str="next" \
    '
    function exec_surround(\
    	exist_target_char, \
    	surround_char \
    ){
    	double_quote_surround = \
			match($0, /^\x22.*\x22$/)
		if(double_quote_surround){ 
			print $0
			return next_str
		}
		signle_quote_surround = \
			match($0, /^\x27.*\x27$/)
		if(signle_quote_surround){
			print $0
			return next_str
		}
    	if(!exist_target_char) return
    	prefix_surrounded = match($0, "^"surround_char)
		if(prefix_surrounded) {
			print $0""surround_char
			return next_str
		}
		suffix_surrounded = match($0, surround_char"$")
		if(suffix_surrounded){
			print surround_char""$0
			return next_str
		}
		print surround_char""$0""surround_char
		return next_str
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
		return_next = ""
		return_next = exec_surround(\
    		single_quote_middle_exist, \
    		"\x22" \
    	)
    	if(return_next == next_str) next

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
		space_exist = \
			hankaku_space_exist \
				+ zenkaku_space_exist
		single_quote_exist = match(\
			$0, /\x27/ \
		)
		double_quote_exist = match(\
			$0, /\x22/ \
		)
		space_quotes_exist = \
			hankaku_space_exist \
				+ zenkaku_space_exist \
				+ single_quote_exist \
				+ double_quote_exist		
		if(\
			!space_exist \
			&& !single_quote_exist \
			&& !double_quote_exist \
		) {
			print $0
			next
		}
		if(single_quote_exist) \
			exec_surround(\
	    		space_exist+1, \
	    		"\x27" \
	    	)
	    if(double_quote_exist) \
			exec_surround(\
	    		space_exist+1, \
	    		"\x22" \
	    	)
		exec_surround(\
    		space_exist+1, \
    		"\x22" \
    	)
    }' 
}