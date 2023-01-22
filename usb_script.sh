#!/usr/bin/env bash

trap_c()
{	
	echo ""
	echo ""
	echo "Please use command \"exit\" to exit usb helper."
	echo ""
	echo -n "> "
}

echo ""
echo "                  USB HELPER"
echo "-----------------------------------------------"
echo ""

echo "Type \"help\" for help, and make sure to only mount 1 drive at a time!"
echo ""

drive_directory="none"

#Make a new directory at /home/user called "Mounts
cd ~/
mkdir Mounts > /dev/null 2>&1

while [ 1 ]
do

	trap trap_c  2
	echo -n "> "
	#Get user input
	read command_input

	#Prints every command for this program
	if [ $command_input = "help" ] > /dev/null 2>&1
	then
		echo ""
		echo "exit: Exit the running program."
		echo "help: Print all commands."
		echo "mount: Mount an unmounted drive."
		echo "dmount: Unmount your mounted drive."
		echo "list: List all current drives."
		echo "dir: List the directory of the opened usb."

	elif [ $command_input = "mount" ] > /dev/null 2>&1
	then

		#Gets drive to mount
		echo ""
		echo -n "What is the directory of your usb? (ex: /dev/sdc): "
		read temp_directory
		if [ $drive_directory = $temp_directory ]
		then
			echo "Usb already mounted."
			exit 0
		fi
		
		drive_directory=$temp_directory

		#Mounts drive
		sudo mount $drive_directory ~/Mounts/Mounted > /dev/null 2>&1
		echo ""
		echo "Operation complete."
	
	#Unmounts the drive that is currently mounted
	elif [ $command_input = "dmount" ] > /dev/null 2>&1
	then
	
		sudo umount ~/Mounts/Mounted > /dev/null 2>&1
		drive_directory="none"
		echo ""
		echo "Operation complete."		

	#The program is terminated
	elif [ $command_input = "exit" ] > /dev/null 2>&1
	then
		sudo umount ~/Mounts/Mounted > /dev/null 2>&1
		exit 0

	#Lists all open usb ports
	elif [ $command_input = "list" ] > /dev/null 2>&1
	then
		echo ""
		df

	#Tells the user the directory of the opened usb
	elif [ $command_input = "dir" ] > /dev/null 2>&1
	then
		if [ $drive_directory != "none" ]
		then
			echo ""
			echo "To get to the usb, press ctrl+alt+t"
			echo "and type into your terminal \"cd ~/Mounts/Mounted/\"."
		else
			echo ""
			echo "There is no mounted drive."
		fi
		
		
	#Pass and continue the while loop
	else
		echo ""
		echo "Unrecognized command."
		
	fi

echo ""
done
