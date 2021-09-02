set PATH=C:\MATLAB\PS_Ser_R2021a\polyspace\bin;%PATH%
set ps_helper_access=polyspace-access -host BGL-PMATHAPA -port 8085 -protocol http -login admin -encrypted-password PJJBJHMADIMOPCNPBDEJBPBJNENOAPCB
set RESULT=ResultBF
set PROG=DemoPaAcc
set PARENT_PROJECT_ON_ACCESS=/public/DemoPaAcc
set WSP=%WORKSPACE%
rd /S /Q Notification && md Notification

set build_cmd=build.bat

polyspace-configure.exe -allow-overwrite -allow-build-error -prog %PROG% -author jenkins -output-options-file %PROG%.psopts %build_cmd% || EXIT /B 200

polyspace-bug-finder-server.exe -options-file "%WSP%\Demo_1\target.opts" -options-file "%WSP%\Demo_1\%PROG%.psopts" -results-dir "%WSP%\R_BF_%BUILD_NUMBER%"   ||  EXIT /B 200

%ps_helper_access% -create-project %PARENT_PROJECT_ON_ACCESS%    ||  EXIT /B 200

%ps_helper_access% -upload "%WSP%\R_BF_%BUILD_NUMBER%" -parent-project %PARENT_PROJECT_ON_ACCESS% -project "%PROG%_%BUILD_NUMBER%"	||  EXIT /B 200

%ps_helper_access% -export %PARENT_PROJECT_ON_ACCESS%/%PROG%_%BUILD_NUMBER% -output Results_All.tsv -defects High    ||  EXIT /B 200

exit 0


