:: Base setup for Windows 10 laptops
:: Run from cmd.exe in Administrative Mode

:: install Chocolatey
WHERE choco
IF %ERRORLEVEL% NEQ 0 @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

:: install 
choco install -y -r googlechrome googledrive lastpass openvpn slack screenpresso \

@ECHO OFF

:devchoice
set /P c=Will this laptop be used for development? [Y/N]
if /I "%c%" EQU "Y" goto :dev
if /I "%c%" EQU "N" goto :designchoice
goto :devchoice

:dev
choco install -y -r visualstudiocode github-desktop heroku-cli awscli vcxsrv chromedriver
:: install development environment into WSL
bash -c "$(curl -fsSL https://github.com/ResaleAI/laptop_setup/raw/master/rubydev_wsl.sh)"

:designchoice
set /P c=Will this laptop be used for design? [Y/N]
if /I "%c%" EQU "Y" goto :design
if /I "%c%" EQU "N" goto :analysischoice
goto :designchoice

:design
choco install -y -r inkscape gimp

:analysischoice
set /P c=Will this laptop be used for analysis? [Y/N]
if /I "%c%" EQU "Y" goto :analysis
if /I "%c%" EQU "N" goto :cleanup
goto :analysischoice

:analysis
choco install -y -r r.project r.studio

:cleanup
:: remove all the crap off the desktop
for %i in (C:\Users\Public\Desktop\*.lnk) do del "%i"
