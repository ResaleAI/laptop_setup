:: Base setup for Windows 10 laptops
:: Run from cmd.exe in Administrative Mode

:: install Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

:: install 
choco install -y ccleaner googlechrome googledrive lastpass openvpn slack

@ECHO OFF

:devchoice
set /P c=Will this laptop be used for development? [Y/N]
if /I "%c%" EQU "Y" goto :dev
if /I "%c%" EQU "N" goto :designchoice
goto :devchoice

:dev
choco install -y visualstudiocode github-desktop heroku-cli awscli vcxsrv
:: install development environment into WSL

:designchoice
set /P c=Will this laptop be used for design? [Y/N]
if /I "%c%" EQU "Y" goto :design
if /I "%c%" EQU "N" goto :analysischoice
goto :designchoice

:design
choco install -y inkscape gimp

:analysischoice
set /P c=Will this laptop be used for analysis? [Y/N]
if /I "%c%" EQU "Y" goto :analysis
if /I "%c%" EQU "N" goto :cleanup
goto :analysischoice

:analysis
choco install -y r.project r.studio

:cleanup
:: remove all the crap off the desktop
