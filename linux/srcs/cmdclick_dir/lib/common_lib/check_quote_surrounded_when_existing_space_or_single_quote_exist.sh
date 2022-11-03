#!/bin/bash


check_quote_surrounded_when_existing_space_or_single_quote_exist(){
	local input_string="${1}"
	echo "${input_string}" \
	| awk '
		{
			if($0 ~ "^[a-zA-Z0-9_-]*=\x27.*\x27.*\x27$") {
				printf "\x5C\x74- single quote sorrunded invalid when single quote used on the way\x5C\x6E"
				printf "\x5C\x74\x5C\x74 ("$0")\x5C\x6E"
			}
			if($0 !~ "\x20") next
			if($0 ~  "^[a-zA-Z0-9_-]*=\x27.*\x27$") next
			if($0 ~  "^[a-zA-Z0-9_-]*=\x22.*\x22$") next
			no_surrounded_str = substr($0, 1, index($0, "="))
			printf "\x5C\x74- blank isn\x27t included by quote in bellow field\x5C\x6E"
			printf "\x5C\x74\x5C\x74 ("$0")\x5C\x6E"
		}'
	}