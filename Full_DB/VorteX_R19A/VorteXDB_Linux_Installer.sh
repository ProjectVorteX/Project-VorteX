#!/bin/bash
# Credits to: 
# Based on the original Arkania.net bat installer
# Linux database installer converted from windows batch file. by Maibenrai
# Modified for use for VorteX DB by Catacrunch

updatetime= October 30,2012 15:39pm
dbrev= R18A
lstat=Under Development
ver=RXX
ver2=RXX

local_sp=./database/development/locals/spanish/
local_gr=./database/development/locals/german/
local_ru=./database/development/locals/russian/
local_it=./database/development/locals/italian/
local_fr=./database/development/locals/french/
vordumppath=./db_backups/VorteX_character_dump/
vorwdumppath=./db_backups/VorteX_world_dump/
mysqlpath=./database/dep/mysql/
devcsql=./base sql/VorteX/character/
devasql=./base sql/VorteX/auth/
rev_update=./database/rev_update/
vorworl2=./database/main_db/world_VorteX_DATA/
vorworl=./database/main_db/world_VorteX_STRUCTURE/
procsql=./database/main_db/procs/

databaseinfo () 
{
	clear
	echo ""
	echo "                                                    /***       /***"
	echo "    /***         /***                               /***     /***"
	echo "     /***       /***                                 /***   /***"
	echo "      /***     /*** /*****  /****   /****** /*****    /*** /***"
	echo "       /***   /*** /**  /** /** /** ///**   /**        /******"
	echo "        /*** /***  /**  /** /** /**   /**   /****     /*** /***"
	echo "         /******   /**  /** /** **    /**   /****    /***   /***"
	echo "          /****    /**  /** /** /**   /**   /**     /***     /***"
	echo "           /**      /*****  /**  /**  /**   /***** /***       /***"
	echo "            //       /////  ///  ///  ///   ///////***         /***"
	echo "                                                  ////         ////   "    
	echo ""
	echo "    ***************************************************************"
	echo "    *              Project VorteX Installation Tool               *"
	echo "    *                        2011-2012                            *"
	echo "    *  DB Version:$dbrev  -  Updated on:$updatetime  *"
	echo "    *                           for                               *"
	echo "    *                  VorteX CORE and ArkCORE                    *"
	echo "    ***************************************************************"
	echo ""
	read -p " What is your MySQL host name?          [localhost]  :" host
	if [ -z "$host" ]; then host=localhost; fi

	read -p " What is your MySQL user name?          [root]       :" user
	if [ -z "$user" ]; then user=root; fi

	read -p " What is your MySQL password?           [ ]          :" pass
	if [ -z "$pass" ]; then pass= ;fi

	read -p " What is your MySQL Port Number?        [3306]       :" port
	if [ -z "$port" ]; then port=3306; fi

	read -p " What is your World database name?      [arkdb]      :" world_db
	if [ -z "$world_db" ]; then world_db=vortex_db; fi

	read -p " What is your Characters database name? [characters] :" char_db
	if [ -z "$char_db" ]; then char_db=characters; fi

	read -p " What is your Auth database name?       [auth]       :" auth_db
	if [ -z "$auth_db" ]; then auth_db=auth; fi 

}

title(){
clear
	echo ""
	echo "                                                    /***       /***"
	echo "    /***         /***                               /***     /***"
	echo "     /***       /***                                 /***   /***"
	echo "      /***     /*** /*****  /****   /****** /*****    /*** /***"
	echo "       /***   /*** /**  /** /** /** ///**   /**        /******"
	echo "        /*** /***  /**  /** /** /**   /**   /****     /*** /***"
	echo "         /******   /**  /** /** **    /**   /****    /***   /***"
	echo "          /****    /**  /** /** /**   /**   /**     /***     /***"
	echo "           /**      /*****  /**  /**  /**   /***** /***       /***"
	echo "            //       /////  ///  ///  ///   ///////***         /***"
	echo "                                                  ////         ////   "    
	echo "                            $dbrev"
}

OPTIONS (){
clear
title
echo "What do you want to do?"
echo ""
echo "------------[ Full VorteX $ver ] ------------"
echo "1) - Install full VorteX DB."
echo "3) - More Options (Convert/BackUp-DB)"
echo ""
read -p " Select an option [1-Default] : " option
	if [ -z "$option" ]; then option=1 ;fi
case "$option" in
1) WARNING;;
2) update;;
3) moreoptions;;
*) OPTIONS;;
esac
#if $option==1 (GOTO WARNING)
#if %option%==3 (goto MOREOPTIONS)
#if %option%==* (goto TITLE)
}

WARNING(){
clear
title
echo ""
echo "=============================================================="
echo "========================== WARNING! =========================="
echo "=============================================================="
echo ""
echo "Are you sure you want to empty the database $world_db and "
echo "install a full VorteXDB $dbrev. This task will erase all"
echo "your custom fix did by yourself and install the full VorteXDB"
echo ""
read -p " Are you sure? [Y/n] : " wa
  if [ -z "$wa" ]; then wa="Y" ;fi
case "$wa" in
Y) structure;;
y) structure;;
N) title
OPTIONS;;
n) title
OPTIONS;;
*) WARNING;;
esac
}

structure(){
clear
title
for sqlfile in $vorworl/*.sql 
    do 
echo "Importing: $sqlfile"
mysql --host=$host --user=$user --password=$pass --port=$port $world_db < "$sqlfile"
echo "				ok."
done
vortexdb
}

moreoptions(){
clear
title
echo "1) - Backup Your World Database."
echo "2) - Backup Character Database."
echo "3) - Import Locals"
echo "4) - Back to Install Options."
echo "5) - Exit the installer."
read -p " Select an option [4-Default] : " mo
  if [ -z "$mo" ]; then mo="4" ;fi
case "$mo" in
1) dumpworld;;
2) dumpchar;;
3) locals;;
4) OPTIONS;;
5) echo "exiting...";;
*) starting;;
esac
}

dumpchar ()
{
clear
title
	sqlname=$(date +"charDMY-"+"%d_%m_%Y")	
	if [ ! -d $vordumppath ]; then
		mkdir $vordumppath 
	fi
	echo " Dumping $sqlname.sql to $vordumppath"
	mysqldump --host=$host --user=$user --password=$pass --port=$port --routines --skip-comments --result-file="$vordumppath/$sqlname.sql" $char_db
moreoptions
}

dumpworld ()
{
clear
title
	sqlname=$(date +"worldDMY-"+"%d_%m_%Y")	
	if [ ! -d $vorwdumppath ]; then
		mkdir $vorwdumppath 
	fi
	echo " Dumping $sqlname.sql to $vorwdumppath"
	mysqldump --host=$host --user=$user --password=$pass --port=$port --routines --skip-comments --result-file="$vorwdumppath/$sqlname.sql" $world_db
moreoptions
}


locals ()
{
clear
title
echo ""
ECHO  "        **************************************************"
ECHO  "        *                                                *"
ECHO  "        *      Please select your language               *"
ECHO  "        *                                                *"
ECHO  "        *     1.          Spanish   "Applied"            *"
ECHO  "        *                                                *"
ECHO  "        *     2.          German    "Applied"            *"
ECHO  "        *                                                *"
ECHO  "        *     3.          Russian   "No Data Yet"        *"
ECHO  "        *                                                *"
ECHO  "        *     4.          Italian   "No Data Yet"        *"
ECHO  "        *                                                *"
ECHO  "        *     5.          French    "Applied"            *"
ECHO  "        *                                                *"
ECHO  "        *     7.          Main Menu                      *"
ECHO  "        *                                                *"
ECHO  "        **************************************************"
ECHO ""
read -p " Select an option [7-Back] : " loc
  if [ -z "$loc" ]; then loc="7" ;fi
case "$loc" in
1) install_sp;;
2) install_gr;;
3) install_ru;;
4) install_it;;
5) install_fr;;
7) echo "exiting...";;
*) starting;;
esac
}

install_sp ()
{
clear
title
echo ""
echo "Importing Spanish Data now..."
echo ""
for sqlfile in $local_sp/*.sql 
	do 
		echo " Importing: $sqlfile"
		mysql --host=$host --user=$user --password=$pass --port=$port $world_db < "$sqlfile"
		echo "				ok."
	done
moreoptions
}

install_gr ()
{
clear
title
echo ""
echo "Importing German Data now..."
echo ""
for sqlfile in $local_gr/*.sql 
	do 
		echo " Importing: $sqlfile"
		mysql --host=$host --user=$user --password=$pass --port=$port $world_db < "$sqlfile"
		echo "				ok."
	done
moreoptions
}

install_ru ()
{
clear
title
echo ""
echo "Importing Russian Data now..."
echo ""
for sqlfile in $local_ru/*.sql 
	do 
		echo " Importing: $sqlfile"
		mysql --host=$host --user=$user --password=$pass --port=$port $world_db < "$sqlfile"
		echo "				ok."
	done
moreoptions
}

install_it ()
{
clear
title
echo ""
echo "Importing Italian Data now..."
echo ""
for sqlfile in $local_it/*.sql 
	do 
		echo " Importing: $sqlfile"
		mysql --host=$host --user=$user --password=$pass --port=$port $world_db < "$sqlfile"
		echo "				ok."
	done
moreoptions
}

install_fr ()
{
clear
title
echo ""
echo "Importing French Data now..."
echo ""
for sqlfile in $local_fr/*.sql 
	do 
		echo " Importing: $sqlfile"
		mysql --host=$host --user=$user --password=$pass --port=$port $world_db < "$sqlfile"
		echo "				ok."
	done
moreoptions
}

vortexdb (){
clear
title
echo ""
echo "Importing Data now..."
echo ""
	for sqlfile in $procsql/*.sql 
	do 
		echo " Importing: $sqlfile"
		mysql --host=$host --user=$user --password=$pass --port=$port $world_db < "$sqlfile"
		echo "				ok."
	done
	    for sqlfile in $vorworl2/*.sql 
	do 
		echo " Importing: $sqlfile"
		mysql --host=$host --user=$user --password=$pass --port=$port $world_db < "$sqlfile"
		echo "				ok."
	done
clear
title
read -p " Do you want to install Characters and Auth DB? [y/N]: " odb
  if [ -z "$odb" ]; then odb="N" ;fi
case "$odb" in
N) Finished;;
n) Finished;;
Y) vortexchar;;
y) vortexchar;;
*) Finished;;
esac
}

Finished(){
clear
title
echo "       ///////////////////////////////////////////////////"     
echo "       // Congratulations VorteXDB is ready for use     //"
echo "       // Please check the ArkCORE repository for any   //"
echo "       // world updates "/sql/updates".                   //"
echo "       ///////////////////////////////////////////////////"	
echo ""
echo ""
}

vortexchar ()
{
clear
title
	echo " Importing Characters and Auth DB's now..."
	echo ""
	for sqlfile in $devcsql/character.sql
	do
		echo " Importing: $sqlfile"
		mysql --host=$host --user=$user --password=$pass --port=$port $char_db < "$sqlfile"
		echo "				ok."
	done
	for sqlfile in $devasql/auth.sql
	do
		echo " Importing: $sqlfile"
		mysql --host=$host --user=$user --password=$pass --port=$port $auth_db < "$sqlfile"
		echo "				ok."
	done
Finished
}


update()
{
clear
title
	echo " Updating your database !!"
	echo " Please wait..."
	echo ""
	for sqlfile in $rev_update/*.sql
	do
		echo " Importing: $sqlfile"

		mysql --host=$host --user=$user --password=$pass --port=$port $world_db < "$sqlfile"

	echo "				ok."
	done
clear
title
echo "       ///////////////////////////////////////////////////"         
echo "       // VorteXDB is now up to date                    //"
echo "       // Please check the ArkCORE repository for any   //"
echo "       // world updates /sql/updates.                   //"
echo "       ///////////////////////////////////////////////////"	
}

databaseinfo
title
OPTIONS