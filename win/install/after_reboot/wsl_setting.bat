@echo off
FOR /F "tokens=1" %%F IN (%userprofile%/distri.txt) DO SET ubuntu_wsl_destri_name=%%F
set ubuntu=%ubuntu_wsl_destri_name:-=%
set ubuntu=%ubuntu:.=%
set ubuntu=%ubuntu:U=u%

CALL :decide_title_and_win_max
CALL :update_wsl
CALL :confirm_ubuntu_installed_then_forcus_otherwise_reboot
CALL :install_package_in_ubuntu
CALL :confirm_about_go_to_next "type y , after finished ubuntu package install: "
CALL :set_wt_json
CALL :start_cmdclick
del %0



:decide_title_and_win_max
	title wsl_setting  & timeout 1 & nircmd win max ititle wsl_setting
EXIT /B 0


:update_wsl
	nircmd elevate powershell -c "wsl.exe --update"
EXIT /B 0


:confirm_ubuntu_installed_then_forcus_otherwise_reboot
	timeout 60 /NOBREAK
	wmctrl -a %ubuntu%
	if %errorlevel% neq 0 (
		start  %ubuntu%.exe & timeout 5 /NOBREAK
	)
	wmctrl -a %ubuntu%
	if %errorlevel% neq 0 (
		nircmd elevate powershell -c "wsl.exe --install -d %ubuntu_wsl_destri_name%; wsl.exe --update"
	)
	set /p ok_next_process="please type y, after let VcXsrv to access and typed usename and password in %ubuntu% (otherwise type r for reboot ): "
	if %ok_next_process% equ r (
		shutdown /r /t 0
	) else if %ok_next_process% neq y (
		exit
	)
	wmctrl -l | find "%ubuntu%"
	if %errorlevel% neq 0 (
		exit
	)
EXIT /B 0


:install_package_in_ubuntu
	powershell -c "wslconfig /setdefault %ubuntu_wsl_destri_name%; $base = bash -c 'wslpath -u  ''%userprofile%'''; $base = $base -replace 'home','Users'; echo $base; bash ""$base/cmdclick/win/install/after_reboot/ubuntu_setting.sh"""$base""
EXIT /B 0


:set_wt_json
	set wt_name=wt.exe
	set windows_terminal_name=WindowsTerminal
	start %wt_name%
	timeout 2 /NOBREAK
	powershell -c "Start-Process -Verb RunAs powershell.exe -args '-c ""Set-ExecutionPolicy -Force RemoteSigned; Stop-Process -Name "%windows_terminal_name%" -Force ""'"
	powershell -c " $json_path = Get-ChildItem $HOME\AppData\Local\Packages\  -Filter Settings.json -Recurse | ForEach-Object {$_.FullName} | select-string Microsoft.%windows_terminal_name%; $jsondata = Get-Content -Path  """$json_path""" -Encoding UTF8 |  Out-String | ConvertFrom-Json; $query_json = echo $jsondata.profiles.list | where { $_.name -eq '%ubuntu_wsl_destri_name%' }; echo $query_json.guid; $guid = $query_json.guid; echo $guid;$jsondata.defaultProfile = $guid;  echo $jsondata.defaultProfile; ConvertTo-Json -Depth 4 $jsondata | Out-File  """$json_path""" -Encoding UTF8 "
	CALL :confirm_about_go_to_next ^
			"please type y after finishing powershell setupper: " 
	wsl.exe --shutdown
EXIT /B 0


:start_cmdclick
	start nircmd.exe elevate %wt_name%
	timeout 2 /NOBREAK
	start cmd /c nircmd.exe elevate bash "/usr/local/bin/cmdclick"
EXIT /B 0


:confirm_about_go_to_next
	set /p ok_next_process="%~1"
	if %ok_next_process% neq y exit
EXIT /B 0
