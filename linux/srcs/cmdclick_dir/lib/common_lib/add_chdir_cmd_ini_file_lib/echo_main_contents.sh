#!/bin/bash

echo_main_contents(){
	cat <(echo "") \
		<(echo "SED_TARGET_PATH=\"${CMDCLICK_APP_LIST_PATH}\"") \
		<(echo "sed_ch_dir_path=\$(echo \$${CH_DIR_PATH} | sed -r 's/([^a-zA-Z0-9_-])/\\\\\1/g')" \
				| sed '/^$/d'\
		)\
		<(echo "sed -e \"/\${sed_ch_dir_path}/d\" -e \"1i\${sed_ch_dir_path}\" -i \"\${SED_TARGET_PATH}\"")
}