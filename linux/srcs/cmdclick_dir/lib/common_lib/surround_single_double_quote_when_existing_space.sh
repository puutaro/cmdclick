#!/bin/bash


surround_single_double_quote_when_existing_space(){
	local ini_value_source="${1}"
	echo "${ini_value_source}" \
    | awk '
	    {
			hankaku_space_exist = match($0, /\x20/)
			zenkaku_space_exist = match($0, /　/)
			if(!(hankaku_space_exist + zenkaku_space_exist)) {
				print $0
				next
			}
			signle_quote_surround = match($0, /^\x27.*\x27$/)
			if(signle_quote_surround) {
				print $0
				next
			}
			prefix_signle_quote_surround = match($0, /^\x27/)
			if(prefix_signle_quote_surround){
				print $0"\x27";
				next
			}
			suffix_signle_quote_surround = match($0, /\x27$/)
			if(suffix_signle_quote_surround){
				print "\x27"$0;
				next
			}
			double_quote_surround = match($0, /^\x22.*\x22$/)
			if(double_quote_surround) {
				print $0
				next
			}
			prefix_double_quote_surround = match($0, /^\x22/)
			if(prefix_double_quote_surround){
				print $0"\x22";
				next
			}
			suffix_double_quote_surround = match($0, /\x22$/)
			if(suffix_double_quote_surround){
				print "\x22"$0;
				next
			}
			print "\x22"$0"\x22"
	    }' 
}