#!/bin/bash

folder=$(date +%Y-%m-%d)_$username
folder_location=/home/kali/Seasoup/'Modul 1'/'Soal 1'
log_txt=$folder_location/log.txt
user_txt=$folder_location/users/user.txt

dl_command_start_function(){
	for(( i=$count+1; i<=$n+$count; i++ ))
	do
		wget https://loremflickr.com/320/240 -O "$folder"/PIC_$i.jpg
	done
	zip --password $password -r $folder.zip "$folder"/
	rm -rf $folder
}

unzip_function(){
	unzip -P $password $folder.zip
	rm $folder.zip
	count=$(find $folder -type f | wc -l)
	dl_command_start_function
}

dl_command_function(){
	if [[ ! -f "$folder.zip" ]]
		then
			mkdir "$folder_location"/$folder
			count=0
			dl_command_start_function "N"
	else
		unzip_function
	fi
}

att_command_function(){
	if [[ ! -f "$log_txt" ]]
	then
		echo "No log found!!"
	else
		awk -v user="$username" 'BEGIN {count=0} $5 == user || $9 == user {count++} END {print (count)}' "$log_txt"
	fi
}

login_function(){
	check_user=$(egrep $username "$user_txt")
	check_password=$(egrep $password "$user_txt")

	if [[ ! -f "$user_txt" ]]
		then
			echo "There is no user registered.... yet."
	else
		if [[ -n "$check_user" ]] && [[ -n "$check_password" ]]
			then
				echo "$calendar $time LOGIN:INFO User $username logged in" >> "$log_txt"
				printf "Login success\n- - - - - - - - - - - - - - \n"
				printf "Available Command \ndl <N>	: Download pictures as zip\natt		: Show login log\nEnter command : "
					read command N
				if [[ $command == att ]]
					then
						att_command_function
				elif [[ $command == dl ]]
					then
						dl_command_function "N"
				else
					echo "Please enter a provided command above!!"
				fi
		else
			fail="Failed login attempt on user $username"
			echo $fail
			echo "$calendar $time LOGIN:ERROR $fail" >> "$log_txt"
		fi
	fi
}

#Main
while :
do
	calendar=$(date +%D)
	time=$(date +%T)

	printf "Han login\n"
	printf "Username: "
		read username
	printf "Password: "
		read -s password
	login_function

	printf "Pres CTRL+C to stop...\n\n"
	sleep 1
done


