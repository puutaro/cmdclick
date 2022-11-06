set cmd_click_title="Command Click"
wmctrl.exe -l | find.exe %cmd_click_title%
if %errorlevel% neq 0 (
    nircmd.exe elevate bash "/usr/local/bin/cmdclick"
    exit /b
)
powershell.exe -c "add-type -assembly microsoft.visualbasic; [microsoft.visualbasic.interaction]::AppActivate('%cmd_click_title%')"