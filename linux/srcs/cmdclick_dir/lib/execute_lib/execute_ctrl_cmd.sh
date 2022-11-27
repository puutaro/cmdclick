#!/bin/bash


execute_ctrl_cmd(){
	local cmd_source="${1:-}"
	case "${cmd_source}" in
		"") return
	;; esac
	local ctrl_prefix=$(\
		echo "${cmd_source}" \
			| awk \
			-v ALWAYS_EDIT_EXECUTE="${ALWAYS_EDIT_EXECUTE}" \
			-v ONCE_EDIT_EXECUTE="${ONCE_EDIT_EXECUTE}" \
			-v NO_EDIT_EXECUTE="${NO_EDIT_EXECUTE}" \
			'{
				gsub(/^\x22*/, "", $0)
				gsub(/\x22*$/, "", $0)
				if ($0 ~ "^"ALWAYS_EDIT_EXECUTE) print ALWAYS_EDIT_EXECUTE
				else if ($0 ~ "^"ONCE_EDIT_EXECUTE) print ONCE_EDIT_EXECUTE
				else if ($0 ~ "^"NO_EDIT_EXECUTE) print NO_EDIT_EXECUTE
			}'\
	)
	local cmd=$(\
		echo "${cmd_source}" \
			| awk \
			-v ctrl_prefix="${ctrl_prefix}" \
			'{
				gsub(/^\x22*/, "", $0)
				gsub(/\x22*$/, "", $0)
				sub("^"ctrl_prefix, "", $0)
				if($0 !~ /^$/) print $0
			}'\
	)
	case "${ctrl_prefix}" in
		"${EXEC_EDIT_EXECUTE}"|"") ;;
		*) return;;
	esac
	case "${cmd}" in
		""|"-") return
	;; esac
	bash -c "${cmd}"
}