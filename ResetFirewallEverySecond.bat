@echo off

:loop
netsh firewall reset
timeout /t 1 /nobreak >nul
goto loop