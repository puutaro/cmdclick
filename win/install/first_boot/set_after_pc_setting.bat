

CALL :decide_title_and_win_max
CALL :set_sublime_prefference
CALL :copy_files
CALL :reboot_confirm



:decide_title_and_win_max
	title pc_setting & timeout 1 & nircmd win max ititle pc_setting
EXIT /B 0


:set_sublime_prefference
	SETLOCAL
	set sublime_user_setting_path=\AppData\Roaming\Sublime Text\Packages\User
	set sublime_prefference_file_name=\Preferences.sublime-settings
	if not exist "%userprofile%%sublime_user_setting_path%%sublime_prefference_file_name%" (
		md "%userprofile%%sublime_user_setting_path%"
		powershell.exe -c "$json_path = """"$HOME%sublime_user_setting_path%%sublime_prefference_file_name%""""; echo $json_path; $jsondata = '{"""font_size""": 16,"""word_wrap""": true}'| ConvertFrom-JSON ;echo $jsondata;  ConvertTo-Json -Depth 4 $jsondata | Out-File  """"$json_path"""" -Encoding UTF8"
	)
	ENDLOCAL
EXIT /B 0

:copy_files
	SETLOCAL
	set startup_dir_path=\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
	set install_lib_path=\os_goods\cmdclick\win\install
	copy /Y "%userprofile%%install_lib_path%\files\config.xlaunch" "%userprofile%%startup_dir_path%"
	copy /Y "%userprofile%%install_lib_path%\after_reboot\wsl_setting.bat" "%userprofile%%startup_dir_path%"
	ENDLOCAL
EXIT /B 0


:reboot_confirm
	SETLOCAL
	echo . & echo .
	set /p ok_next_process="type y and reboot for reflecting installed: "
	echo %ok_next_process%
	if %ok_next_process% neq y exit
	ENDLOCAL
	shutdown /r /t 0
EXIT /B 0