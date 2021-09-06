set PATH=C:\MATLAB\PS_Ser_R2021a\polyspace\bin;%PATH%
set ps_helper_access=polyspace-access -host HYD-NALANDA-14 -port 8085 -protocol http -login admin -encrypted-password PJJBJHMADIMOPCNPBDEJBPBJNENOAPCB
set RESULT=ResultBF
set PROG=Wget
set PARENT_PROJECT_ON_ACCESS=/public/
set Options_Dir=C:\My_Drive\Wget\Options
set WSP=%WORKSPACE%
rd /S /Q Notification && md Notification

REM set build_cmd=build.bat

REM polyspace-configure.exe -allow-overwrite -allow-build-error -prog %PROG% -author jenkins -output-options-file %PROG%.psopts %build_cmd% || EXIT /B 200

polyspace-bug-finder-server.exe -options-file "%Options_Dir%\target.opts" -options-file "%Options_Dir%\wget_exe.psopts" -results-dir "%WSP%\R_BF"   ||  EXIT /B 200

cd ..

%ps_helper_access% -create-project %PARENT_PROJECT_ON_ACCESS%    ||  EXIT /B 200

%ps_helper_access% -upload "%WSP%\R_BF" -parent-project %PARENT_PROJECT_ON_ACCESS% -project "%PROG%"	||  EXIT /B 200

%ps_helper_access% -export %PARENT_PROJECT_ON_ACCESS%/%PROG% -output Results_All.tsv -defects High    ||  EXIT /B 200

exit 0


