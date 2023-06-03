@echo off

REM Export the list of user tasks to a temporary file
schtasks /query /FO CSV > tasks.csv

REM Iterate over each line in the CSV file
for /F "skip=1 tokens=1 delims=," %%A in (tasks.csv) do (
    REM Extract the task name from each line
    for /F "tokens=1 delims=," %%B in ("%%A") do (
        REM Delete the task using the task name
        schtasks /delete /tn "%%B" /F >nul
    )
)

REM Clean up the temporary file
del tasks.csv