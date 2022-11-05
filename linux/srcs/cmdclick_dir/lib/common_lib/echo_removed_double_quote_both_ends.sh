#!/bin/bash


echo_removed_double_quote_both_ends(){
	local remove_contents="${1}"
	echo "${remove_contents}" \
		| sed -re 's/^"(.*)"$/\1/' \
			-re "s/^'(.*)'$/\1/"
}

echo_removed_double_quote_both_ends_from_pip(){
	echo_removed_double_quote_both_ends \
		"$(cat "/dev/stdin")"
}