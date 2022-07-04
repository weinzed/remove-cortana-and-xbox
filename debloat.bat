@echo off

echo.
echo  :: Looking for admin privileges.
echo.
timeout /t 1 /nobreak > NUL

if %errorlevel%==0 (
        echo Admin privileges detected. Continuing.
        pause > nul
) else (
        echo  :: You must run this file as Admin privileges
        echo.
        echo     Press right click and select Run as Admin.
        echo.
        echo     Press any key to exit.
        pause > NUL
        exit
)

goto :cortana

:cortana
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
echo.
echo    :: Cortana is removed.
goto selxbox


:selxbox
cls
echo    :: Do you want to remove all XBOX services?
echo    Press 1 for remove all XBOX services.
echo    Press 2 for exit.

set /P menu=
	if %menu%==1 GOTO xbox
	if %menu%==2 GOTO end

else (
    cls
    echo    :: You entered wrong number retry again...
    timeout /t 2 /nobreak > nul
    goto selxbox
)

:xbox

echo Removing XblAuthManager
echo.
sc stop XblAuthManager
sc delete XblAuthManager
cls

echo Removing XblGameSave
echo.
sc stop XblGameSave
sc delete XblGameSave
cls

echo Removing XboxNetApiSvc
echo.
sc stop XboxNetApiSvc
sc delete XboxNetApiSvc
cls

:end

cls
echo    :: This batch script made by github.com/weinzed.
echo    :: Disclaimer: Do not forget to restart your PC.
echo.
echo    :: Done! Press any key to exit.
pause > nul
exit