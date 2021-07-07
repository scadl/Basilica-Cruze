setlocal
set ANDROIDHOME=%ANDROID_HOME%
if NOT "UE_SDKS_ROOT"=="" (call %UE_SDKS_ROOT%\HostWin64\Android\SetupEnvironmentVars.bat)
if "%ANDROIDHOME%"=="" set ANDROIDHOME=D:/EpicGames/NVPACK/android-sdk-windows
set ADB=%ANDROIDHOME%\platform-tools\adb.exe
set DEVICE=
if not "%1"=="" set DEVICE=-s %1
for /f "delims=" %%A in ('%ADB% %DEVICE% shell "echo $EXTERNAL_STORAGE"') do @set STORAGE=%%A
@echo.
@echo Uninstalling existing application. Failures here can almost always be ignored.
%ADB% %DEVICE% uninstall net.scadsdnd.BCruze_UE4
@echo.
@echo Installing existing application. Failures here indicate a problem with the device (connection or storage permissions) and are fatal.
%ADB% %DEVICE% install BCruze_UE4-Android-Shipping-armv7-es2.apk
@if "%ERRORLEVEL%" NEQ "0" goto Error
%ADB% %DEVICE% shell rm -r %STORAGE%/UE4Game/BCruze_UE4
%ADB% %DEVICE% shell rm -r %STORAGE%/UE4Game/UE4CommandLine.txt
%ADB% %DEVICE% shell rm -r %STORAGE%/obb/net.scadsdnd.BCruze_UE4
%ADB% %DEVICE% shell rm -r %STORAGE%/Android/obb/net.scadsdnd.BCruze_UE4
@echo.
@echo Installing new data. Failures here indicate storage problems (missing SD card or bad permissions) and are fatal.
%ADB% %DEVICE% push main.1.net.scadsdnd.BCruze_UE4.obb %STORAGE%/Download/obb/net.scadsdnd.BCruze_UE4/main.1.net.scadsdnd.BCruze_UE4.obb
if "%ERRORLEVEL%" NEQ "0" goto Error
%ADB% %DEVICE% shell mv %STORAGE%/Download/obb/net.scadsdnd.BCruze_UE4 %STORAGE%/Android/obb/net.scadsdnd.BCruze_UE4
if "%ERRORLEVEL%" NEQ "0" goto Error
@echo.



@echo.
@echo Installation successful
goto:eof
:Error
@echo.
@echo There was an error installing the game or the obb file. Look above for more info.
@echo.
@echo Things to try:
@echo Check that the device (and only the device) is listed with "%ADB$ devices" from a command prompt.
@echo Make sure all Developer options look normal on the device
@echo Check that the device has an SD card.
@pause