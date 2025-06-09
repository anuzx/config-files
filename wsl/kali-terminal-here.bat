@echo off
set "win_path=%cd%"
for /f "delims=" %%i in ('wsl wslpath "%win_path%"') do set "linux_path=%%i"
wt.exe -p "kali-linux" --title "Kali Here" wsl -d kali-linux --cd "%linux_path%"
