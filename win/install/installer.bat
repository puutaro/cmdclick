start cmd /c "title install_message & echo . & echo . & echo launch powershell installer ... & timeout 120 > NUL & echo . & echo . & echo start install & echo . & echo . & echo if wsl --install -d Ubuntu-20.04 failure or freeze on the way, & echo . & echo please bellow procedure & echo . & echo ^-^>  please retry double click %userprofile%\os_goods\cmdclick\win\install\after_reboot\wsl_setting.bat & timeout 50000"

powershell -c "Start-Process -Verb RunAs powershell.exe -args '-c ""Set-ExecutionPolicy -Force RemoteSigned; start-sleep 3; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString(''https://community.chocolatey.org/install.ps1'')); $env:Path = [System.Environment]::GetEnvironmentVariable(''Path'',''Machine'') + '';'' + [System.Environment]::GetEnvironmentVariable(''Path'',''User''); Set-ExecutionPolicy Bypass -Scope Process -Force;  choco config set --name commandExecutionTimeoutSeconds --value 5400; start-sleep 5;  $env:Path = [System.Environment]::GetEnvironmentVariable(''Path'',''Machine'') + '';'' + [System.Environment]::GetEnvironmentVariable(''Path'',''User''); Set-ExecutionPolicy Bypass -Scope Process -Force;  choco install -y git;  $env:Path = [System.Environment]::GetEnvironmentVariable(''Path'',''Machine'') + '';'' + [System.Environment]::GetEnvironmentVariable(''Path'',''User''); Set-ExecutionPolicy Bypass -Scope Process -Force; git config --global core.autocrlf input; cd $HOME; git clone https://github.com/kitamura-take/os_goods.git;   git config --global core.autocrlf input; cd $HOME; git clone https://github.com/kitamura-take/os_goods.git; powershell """"""""""$HOME\os_goods\cmdclick\win\install\first_boot\pc_setting.ps1""""""""""; ""'"