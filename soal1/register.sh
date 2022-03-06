#!/bin/bash

folder_location=/home/phacktrick/Fachren/Program/Seasoup/'Modul 1'/'Soal 1'
user_location="$folder_location"/users

if [[ ! -d "$user_location" ]]
	then
		mkdir "$folder_location"/users
		touch "$folder_location"/users/user.txt
fi

if [[ ! -f "$user_location"/log.txt ]]
	then
		touch "$folder_location"/log.txt
fi

check_password_function() {
	if grep -q $username "$user_location"/user.txt
		then
			user_exist="User already exist."
			echo $user_exist
			echo $calendar $time REGISTER:ERROR $user_exist >> $folder_location/log.txt
			return
	elif [[ ${#password} -lt 8 ]]
		then
			echo "Warning!!Password must be more than 8 characters."
	elif [[ "$password" != *[[:upper:]]* || "$password" != *[[:lower:]]* || "$password" != *[0-9]* ]]
		then
			echo "Warning!!Password must contain uppercase, lowercase, AND number."
	elif [[ $password == $username ]]
		then
			echo "Warning!!Password cannot be the same as username."
	else
			echo "User $username registered successfully"
			echo $calendar $time REGISTER:INFO User $username registered successfully >> "$folder_location"/log.txt
			echo $username $password >> "$user_location"/user.txt
	fi
}

#Main
while :
do
	calendar=$(date +%D)
	time=$(date +%T)
	printf "Han register\n"
	printf "Username: "
		read username
	printf "Password: "
		read -s password

	check_password_function
	printf "Pres CTRL+C to stop... \n\n"
	sleep 1
done
