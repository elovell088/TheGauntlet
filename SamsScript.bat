@echo off

REM Disable Remote Assistance
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 0 /f

REM Disable Remote Desktop
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f

REM Enable Windows Firewall
netsh firewall set opmode enable

REM Disable Simple File Sharing
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v forceguest /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymous /t REG_DWORD /d 1 /f

REM Disable AutoPlay
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f

REM Disable Guest Account
net user guest /active:no

REM Disable Local Administrator Account
net user administrator /active:no

REM Enable Strong Password Policy
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Network" /v MinPwdLen /t REG_DWORD /d 8 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Network" /v PasswordHistorySize /t REG_DWORD /d 5 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Network" /v LockoutBadCount /t REG_DWORD /d 5 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Network" /v RequireLogonToChangePassword /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Network" /v RequireSecureLogon /t REG_DWORD /d 1 /f

REM Disable LM and NTLMv1 Authentication
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa" /v LMCompatibilityLevel /t REG_DWORD /d 5 /f

REM Enable Windows Update Automatic Updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f

REM Enable DEP (Data Execution Prevention)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f

REM Disable NetBIOS over TCP/IP
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v NetBIOSOptions /t REG_DWORD /d 2 /f

REM Disable Server Message Block (SMB) version 1
sc config lanmanworkstation start=disabled
sc config lanmanserver start=disabled

REM Disable Automatic Updates BITS Background Intelligent Transfer Service
sc config BITS start=disabled

REM Disable Messenger Service
sc config messenger start=disabled

REM Disable Telnet Service
sc config TlntSvr start=disabled

REM Disable Remote Registry Service
sc config RemoteRegistry start=disabled

REM Disable VNC Server Service
sc config "winvnc" start=disabled

REM Disable unnecessary ports
netsh advfirewall firewall add rule name="Block Port 12345" dir=in action=block protocol=TCP localport=12345
netsh advfirewall firewall add rule name="Block Port 54321" dir=in action=block protocol=TCP localport=54321
netsh advfirewall firewall add rule name="Block Port 9876" dir=in action=block protocol=TCP localport=9876
netsh advfirewall firewall add rule name="Block Port 139" dir=in action=block protocol=TCP localport=139
netsh advfirewall firewall add rule name="Block Port 135" dir=in action=block protocol=TCP localport=135
netsh advfirewall firewall add rule name="Block Port 445" dir=in action=block protocol=TCP localport=445
netsh advfirewall firewall add rule name="Block Port 3389" dir=in action=block protocol=TCP localport=3389

REM Disable Print Spooler Service and Port
sc config Spooler start=disabled
netsh advfirewall firewall add rule name="Block Port 9100" dir=in action=block protocol=TCP localport=9100

echo Windows XP SP2 hardening completed.
pause