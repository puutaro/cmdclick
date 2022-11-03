

powershell -c "Start-Process -Verb RunAs powershell.exe -args '-c ""Set-ExecutionPolicy -Force RemoteSigned; Remove-Item ''C:\Program Files\cmdclick'' -Recurse; ""'"
del  "%userprofile%\Desktop\start_cmdclick_shortcut.lnk"
del  "%userprofile%\Desktop\wt_up_shortcut.lnk"
CALL :uninstall_package_in_ubuntu
exit

:uninstall_package_in_ubuntu
	powershell -c "$base = bash -c 'wslpath -u  ''%userprofile%'''; $base = $base -replace 'home','Users'; echo $base; bash ""$base/cmdclick/win/install/uninstaller_lib/exec_uninstall.sh"""
EXIT /B 0