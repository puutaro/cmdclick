set cmd_click_title="Command Click"
wmctrl.exe -l | find.exe %cmd_click_title%
if %errorlevel% neq 0 (
    nircmd.exe elevate bash "/usr/local/bin/cmdclick"
    exit /b
)
nircmd.exe win activate title %cmd_click_title%