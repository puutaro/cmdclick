wmctrl -a WindowsTerminal
if %errorlevel% neq 0 (
  nircmd.exe elevate wt.exe 
  timeout 1
  wmctrl.exe -a "WindowsTerminal"
  )