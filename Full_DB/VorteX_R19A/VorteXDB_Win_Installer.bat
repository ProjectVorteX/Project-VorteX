@ECHO OFF
TITLE Project VorteX DB Installer Tool -%dbrev%

rem Credits to:
rem arkania.net, project-silvermoon.net and PDSU for the original basic structure of the .bat installer
rem vortex-db.com for the current version which was created by Catacrunch.

:DEV INFO.. MUST BE UPDATED IF REQUIRED FOR EACH REVISION
SET updatetime= January 11, 2013 
SET dbrev= R19B
SET lstat=Under Development

:TOP
color 1A
CLS
ECHO. 
ECHO                                                    /���       /���
ECHO     /���         /���                               /���     /���
ECHO      /���       /���                                 /���   /���
ECHO       /���     /��� /�����  /����   /������ /�����    /��� /���
ECHO        /���   /��� /��  /�� /�� /�� ///��   /��        /������
ECHO         /��� /���  /��  /�� /�� /��   /��   /����     /��� /���
ECHO          /������   /��  /�� /�� ��    /��   /����    /���   /���
ECHO           /����    /��  /�� /�� /��   /��   /��     /���     /���
ECHO            /��      /�����  /��  /��  /��   /����� /���       /���
ECHO             //       /////  ///  ///  ///   ///////���         /���
ECHO                                                   ////         ////       
ECHO.
ECHO     �������������������������������������������������������������ͻ
ECHO     �              Project VorteX Installation Tool               �
ECHO     �                        2011-2012                            �
ECHO     �    DB Version:%dbrev%  -  Updated on%updatetime%   �
ECHO     �                           for                               �
ECHO     �                  VorteX CORE and ArkCORE                    �
ECHO     �������������������������������������������������������������ͼ
ECHO.
ECHO.
PAUSE
CLS
COLOR 1F
ECHO    Please enter your MySQL infor for the following...
ECHO.
SET /p host=    1) MySQL Server Address [usually localhost] :
if %host%. == . set host=localhost
ECHO.
ECHO -------------------------------------------------------------------
ECHO.
SET /p user=    2) MySQL Username [usually root] : 
if %user%. == . set user=root
SET /p pass=    3) MySQL Password : 
SET /p port=    4) MySQL port [usually 3306] : 
if %port%. == . set port=3306
ECHO.
ECHO -------------------------------------------------------------------
ECHO.
SET /p world_db=    5) World database name : 
if %world_db%. == . set world_db=vortex_world
SET /P char_db=    6) Character database name : 
if %char_db%. == . set char_db=characters

SET vordumppath=.\db_backups\VorteX_character_dump\
SET vorwdumppath=.\db_backups\VorteX_world_dump\
SET mysqlpath=.\database\dep\mysql\
SET devcsql=.\base sql\VorteX\character\
SET devsql=.\database\main_db\world\
SET procsql=.\database\main_db\procs\
SET ask_update=.\database\development\VorteX_update\
SET vorworl=.\database\main_db\world_VorteX_STRUCTURE\
SET vorworl2=.\database\main_db\world_VorteX_DATA\
SET rev_update=.\database\rev_update\
SET local_sp=.\database\development\locals\spanish\
SET local_gr=.\database\development\locals\german\
SET local_ru=.\database\development\locals\russian\
SET local_it=.\database\development\locals\italian\
SET local_fr=.\database\development\locals\french\
SET changsql=.\database\development\VorteX_update\

:Begin
CLS
ECHO.
ECHO          ������������������������������������������������ͻ
ECHO          �                                                �
ECHO          �      Please Choose an option for your DB       �
ECHO          �                                                �
ECHO          �  1. Install VorteX World DB                    �
ECHO          �                                                �          
ECHO          �  3. Install clean Character DB                 �
ECHO          �                                                �
ECHO          �  4. Backup your World DB                       �
ECHO          �  5. Backup your Character DB                   �
ECHO          �                                                �
ECHO          �  6. Apply Locals            %lstat%  �
ECHO          �  7. Change Settings                            �
ECHO          �  X  Exit Install tool                          �
ECHO          �                                                �
ECHO          ������������������������������������������������ͼ
ECHO.

SET /p v= 		Enter your selection: 
IF %v%==1 GOTO import_vorworld
IF %v%==3 GOTO import_vchar
IF %v%==7 GOTO top

IF %v%==4 GOTO dump_vorworld
IF %v%==5 GOTO dump_vorchar

IF %v%==6 GOTO locals

IF %v%==x GOTO exit
IF %v%==X GOTO exit
IF %v%=="" GOTO exit
GOTO error

:import_vorworld
CLS
ECHO. 
ECHO                                                    /���       /���
ECHO     /���         /���                               /���     /���
ECHO      /���       /���                                 /���   /���
ECHO       /���     /��� /�����  /����   /������ /�����    /��� /���
ECHO        /���   /��� /��  /�� /�� /�� ///��   /��        /������
ECHO         /��� /���  /��  /�� /�� /��   /��   /����     /��� /���
ECHO          /������   /��  /�� /�� ��    /��   /����    /���   /���
ECHO           /����    /��  /�� /�� /��   /��   /��     /���     /���
ECHO            /��      /�����  /��  /��  /��   /����� /���       /���
ECHO             //       /////  ///  ///  ///   ///////���         /���
ECHO                                                   ////         ////       
ECHO.
ECHO          ��������������������������������������������������������ͻ
ECHO          �                      WARNING                           �
ECHO          �       You are about to install VorteX World DB         �
ECHO          �  All current data will be overwritten if you continue. �
ECHO          ��������������������������������������������������������ͼ
ECHO.
SET /p wa= Are you sure you want to continue? [Y/n] : 
if %wa%. == . set wa=Y
if %wa%==Y (goto import_world)
if %wa%==y (goto import_world)
if %wa%==n (goto Begin)
if %wa%==N (goto Begin)

:import_world
CLS
ECHO                      VorteX DB installation procedure..
ECHO.
ECHO            1): Preparing Database Setup  
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO          ��������������������������������������������������������ͻ
ECHO          �۲�������������������������������������������������������
ECHO          ��������������������������������������������������������ͼ
ECHO DROP database IF EXISTS `%world_db%`; 
ECHO CREATE database IF NOT EXISTS `%world_db%`; >> %vorworl%\databaseclean.sql
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% < %vorworl%\databaseclean.sql
@DEL %vorworl%\databaseclean.sql

CLS
ECHO.
ECHO                      VorteX DB installation procedure..
ECHO.
ECHO            1): Preparing Database Setup  - OK
ECHO            2): Adding Stored Procedures
ECHO.
ECHO.
ECHO.
ECHO.
ECHO          ��������������������������������������������������������ͻ
ECHO          �����۲���������������������������������������������������
ECHO          ��������������������������������������������������������ͼ
for %%C in (%procsql%\*.sql) do (
	ECHO import: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)

CLS
ECHO.
ECHO                      VorteX DB installation procedure..
ECHO.
ECHO            1): Preparing Database Setup  - OK
ECHO            2): Adding Stored Procedures - OK
ECHO            3): Importing VorteX DB (WORLD)
ECHO.
ECHO.
ECHO.
ECHO          ��������������������������������������������������������ͻ
ECHO          ���������������۲�����������������������������������������
ECHO          ��������������������������������������������������������ͼ
FOR %%C IN (%vorworl%\*.sql) DO (
	ECHO Importing: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)

CLS
ECHO.
ECHO                      VorteX DB installation procedure..
ECHO.
ECHO            1): Preparing Database Setup  - OK
ECHO            2): Adding Stored Procedures - OK
ECHO            3): Importing VorteX DB (WORLD)
ECHO.
ECHO.
ECHO.
ECHO          ��������������������������������������������������������ͻ
ECHO          ��������������������������۲������������������������������
ECHO          ��������������������������������������������������������ͼ
FOR %%C IN (%vorworl2%\*.sql) DO (
	ECHO Importing: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)

CLS
ECHO.
ECHO                      VorteX DB installation procedure..
ECHO.
ECHO            1): Preparing Database Setup  - OK
ECHO            2): Adding Stored Procedures - OK
ECHO            3): Importing VorteX DB (WORLD) - OK
ECHO            4): Importing Critical Updates
ECHO.
ECHO.
ECHO          ��������������������������������������������������������ͻ
ECHO          ���������������������������������������������۲�����������
ECHO          ��������������������������������������������������������ͼ
for %%C in (%changsql%\*.sql) do (
	ECHO import: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)

CLS
ECHO.
ECHO                      VorteX DB installation procedure..
ECHO.
ECHO            1): Preparing Database Setup  - OK
ECHO            2): Adding Stored Procedures - OK
ECHO            3): Importing VorteX DB (WORLD) - OK
ECHO            4): Importing Critical Updates - OK
ECHO.
ECHO.
ECHO          ��������������������������������������������������������ͻ
ECHO          ��������������������������������������������������������ۺ
ECHO          ��������������������������������������������������������ͼ
ECHO Your Installation is complete, your current db is Project VorteX version%dbrev% 
ECHO.
ECHO          ��������������������������������������������������������ͻ
ECHO          �   Please DELETE the contents of your Cache folder in   �
ECHO          �               your WoW install location                �
ECHO          ��������������������������������������������������������ͼ
ECHO.
ECHO                 Thank you for using Project VorteX DB, Enjoy
ECHO.
PAUSE
GOTO Begin

:dump_vorworld
CLS
IF NOT EXIST "%vorwdumppath%" MKDIR %vorwdumppath%
ECHO %world_db% Database Export started...

FOR %%a IN ("%vorworl%\*.sql") DO SET /A Count+=1
setlocal enabledelayedexpansion
FOR %%C IN (%vorworl%\*.sql) DO (
	SET /A Count2+=1
	ECHO Dumping [!Count2!/%Count%] %%~nC
	%mysqlpath%\mysqldump --host=%host% --user=%user% --password=%pass% --port=%port% --skip-comments %world_db% %%~nC > %vorwdumppath%\%%~nxC
)
endlocal 
ECHO  Finished ... %world_db% exported to %wdumppath% folder...
PAUSE
GOTO Begin

:dump_vorchar
CLS
IF NOT EXIST "%vordumppath%" MKDIR %vordumppath%
ECHO %char_db% Database Export started...

FOR %%a IN ("%arkbchar%\*.sql") DO SET /A Count+=1
setlocal enabledelayedexpansion
FOR %%C IN (%arkchar%\*.sql) DO (
	SET /A Count2+=1
	ECHO Dumping [!Count2!/%Count%] %%~nC
	%mysqlpath%\mysqldump --host=%host% --user=%user% --password=%pass% --port=%port% --skip-comments %char_db% %%~nC > %vordumppath%\%%~nxC
)
endlocal 
ECHO  Finished ... %char_db% exported to %cdumppath% folder...
PAUSE
GOTO Begin

:import_vchar
CLS
ECHO. 
ECHO                                                    /���       /���
ECHO     /���         /���                               /���     /���
ECHO      /���       /���                                 /���   /���
ECHO       /���     /��� /�����  /����   /������ /�����    /��� /���
ECHO        /���   /��� /��  /�� /�� /�� ///��   /��        /������
ECHO         /��� /���  /��  /�� /�� /��   /��   /����     /��� /���
ECHO          /������   /��  /�� /�� ��    /��   /����    /���   /���
ECHO           /����    /��  /�� /�� /��   /��   /��     /���     /���
ECHO            /��      /�����  /��  /��  /��   /����� /���       /���
ECHO             //       /////  ///  ///  ///   ///////���         /���
ECHO                                                   ////         ////       
ECHO.
ECHO          ��������������������������������������������������������ͻ
ECHO          �                      WARNING                           �
ECHO          �  You are about to install a clean/empty character DB   �
ECHO          �  All your current data will be lost if you continue.   �
ECHO          ��������������������������������������������������������ͼ
ECHO.
SET /p wa= Are you sure you want to continue? [Y/n] : 
if %wa%. == . set wa=Y
if %wa%==Y (goto import_character)
if %wa%==y (goto import_character)
if %wa%==n (goto Begin)
if %wa%==N (goto Begin)

:import_character
CLS
ECHO.
ECHO Cleaning out your Character DB... 
ECHO DROP database IF EXISTS `%char_db%`; > %vorworl%\databaseclean.sql
ECHO CREATE database IF NOT EXISTS `%char_db%`; >> %vorworl%\databaseclean.sql
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% < %vorworl%\databaseclean.sql
@DEL %vorworl%\databaseclean.sql
for %%C in (%devcsql%\character.sql) do (
ECHO.
ECHO Importing clean Character DB: %%~nxC
%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %char_db% < "%%~fC"
)
ECHO.
ECHO VorteX Character DB has now been Imported...
ECHO.
PAUSE   
GOTO Begin

:locals
CLS
ECHO          ������������������������������������������������ͻ
ECHO          �                                                �
ECHO          �      Please select your language               �
ECHO          �                                                �
ECHO          �     S.          Spanish   "Applied"            �
ECHO          �                                                �
ECHO          �     G.          German    "Applied"            �
ECHO          �                                                �
ECHO          �     R.          Russian   "No Data Yet"        �
ECHO          �                                                �
ECHO          �     I.          Italian   "No Data Yet"        �
ECHO          �                                                �
ECHO          �     F.          French    "Applied"            �
ECHO          �                                                �
ECHO          �     B.          Main Menu                      �
ECHO          �                                                �
ECHO          ������������������������������������������������ͼ
ECHO.
set /p ch=      Letter: 
ECHO.
IF %ch%==s GOTO install_sp
IF %ch%==S GOTO install_sp
IF %ch%==g GOTO install_gr
IF %ch%==G GOTO install_gr
IF %ch%==r GOTO install_ru
IF %ch%==R GOTO install_ru
IF %ch%==i GOTO install_it
IF %ch%==I GOTO install_it
IF %ch%==f GOTO install_fr
IF %ch%==F GOTO install_fr
IF %ch%==b GOTO begin
IF %ch%==B GOTO begin
IF %ch%=="" GOTO locals
GOTO error

:install_sp
ECHO Importing Spanish Data now...
ECHO.
FOR %%C IN (%local_sp%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO Spanish Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin

:install_gr
ECHO Importing German Data now...
ECHO.
FOR %%C IN (%local_sp%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO German Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin

:install_ru
ECHO Importing Russian Data now...
ECHO.
FOR %%C IN (%local_sp%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO Russian Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin

:install_it
ECHO Importing Italian Data now...
ECHO.
FOR %%C IN (%local_it%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO Italian Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin

:install_fr
ECHO Importing French Data now...
ECHO.
FOR %%C IN (%local_fr%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO French Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin


:error
ECHO	Please enter a correct character.
ECHO.
PAUSE
GOTO Begin

:error2
ECHO	Changeset with this number not found.
ECHO.
PAUSE
GOTO Begin

:exit