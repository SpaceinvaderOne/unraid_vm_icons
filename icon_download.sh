#!/bin/bash
#downloads custom icons from online icon repository to array then copies them into vm manager. 
#
#set below to [0 - First copies icons to category folders, so you can choose which icons to have copied to the system] 
#set below to [1 - direct downloads all icons without categories then copies them to your system without user choice]
direct_copy_icons="1"

#set location on server for download of icons if above not set to direct
downloadlocation="/mnt/user/system"
#
#
#optional push notifications set below leave all settings below if none required
#
#
#set whether to use pushnotication on download of new icons [0- none] [1-pushover] [2-pushbullet] 
pushnotifications="0"
#pushover api (only fill in if set above to pushover above)
apitoken="token=put your pushover token here"
userkey="user=put your pushover user key here"
#pushbullet api (only fill in if set above to pushbullet above)
API="put your push bullet api key here"

#dont change anything below here ***********************************************************************************
#
dirtemp=$downloadlocation"/icons/temp"
dirstore=$downloadlocation"/icons/store"
dirbanner=$downloadlocation"/icons/banners"
#set function "pushnotice" to push type

if [[ "$pushnotifications" =~ ^(1|2)$ ]]; then

	if [ "$pushnotifications" -eq 1 ]; then

		function pushnotice {
				 curl -s \
			--form-string $apitoken \
			--form-string $userkey \
			--form-string "message=$1" \
			https://api.pushover.net/1/messages.json
			}
			echo "set for pushover"


		elif [ "$pushnotifications" -eq 2 ]; then

			function pushnotice {
			curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="unRAID vm icons" -d body="$1"
			}

			echo "set for pushbullet"			

		fi

	else

		function pushnotice {
			echo "$1"
		}

	fi
	if [ ! -d $dirtemp ] ; then

				echo "Setting up first folder $dirtemp "

				# make the temp directory as it doesnt exist
				mkdir -vp $dirtemp
			else
				echo "continuing."

				fi	
	#check if array if banner location exist
			if [ ! -d $dirbanner ] ; then

						echo "Setting up banner folder $dirbanner "

						# make the temp directory as it doesnt exist
						mkdir -vp $dirbanner
					else
						echo "continuing."

						fi	
		#check if array if store location exist				

			if [ ! -d $dirstore ] ; then

									echo "Setting up second folder $dirtemp "

									# make the store directory as it doesnt exist
									mkdir -vp $dirstore
								else
									echo "All folders needed are already created continuing."
									fi

if [[ "$direct_copy_icons" =~ ^(0|1)$ ]]; then


if [ "$direct_copy_icons" -eq 0 ]; then

# set download location to temp folder for user to sort
	echo "information: direct_copy_icons flag is 0. Icons will be copied to array first for manual sorting."
	download=$dirtemp
	#set wget to download with folder structure for user sorting
	get="-r -c -S -N -nH -e robots=off -np -A png -R index.html* http://spaceinvader.one/unraidvmicons/"
	getbanner="-r -c -S -N -nH -e robots=off -np -A png -R index.html* http://spaceinvader.one/unraidbanners/"
	#set what to do at end of script
	end=0



elif [ "$direct_copy_icons" -eq 1 ]; then

# set download location to store folder then copy to system
	echo "information: direct_copy_icons flag is 1.Icons will be copied directly to system without user intervention"



	download=$dirstore
	#set wget to download without folder structure as direct to system
	get="-r -c -S -N -nH -e robots=off -nd -np -A png -R index.html* http://spaceinvader.one/unraidvmicons/"
	getbanner="-r -c -S -N -nH -e robots=off -np -A png -R index.html* http://spaceinvader.one/unraidbanners/"
	#set what to do at end of script
	end=1
fi

else
echo "failure: direct_copy_icons is $direct_copy_icons. this is not a valid format. expecting [0 - array first] or [1 - direct to system]. exiting."

exit 1
fi


					echo "'______'''_______''_'''''_''__''''_''___''''''_______''_______''______'''___'''__''''_''_______'";
					echo "|''''''|'|'''''''||'|'_'|'||''|''|'||'''|''''|'''''''||'''_'''||''''''|'|'''|'|''|''|'||'''''''|";
					echo "|''_''''||'''_'''||'||'||'||'''|_|'||'''|''''|'''_'''||''|_|''||''_''''||'''|'|'''|_|'||''''___|";
					echo "|'|'|'''||''|'|''||'''''''||'''''''||'''|''''|''|'|''||'''''''||'|'|'''||'''|'|'''''''||'''|'__'";
					echo "|'|_|'''||''|_|''||'''''''||''_''''||'''|___'|''|_|''||'''''''||'|_|'''||'''|'|''_''''||'''||''|";
					echo "|'''''''||'''''''||'''_'''||'|'|'''||'''''''||'''''''||'''_'''||'''''''||'''|'|'|'|'''||'''|_|'|";
					echo "|______|'|_______||__|'|__||_|''|__||_______||_______||__|'|__||______|'|___|'|_|''|__||_______|";
					echo "'''''''''''''''''''''''''___'''_______''_______''__''''_''_______'''''''''''''''''''''''''''''''";
					echo "''''''''''''''''''''''''|'''|'|'''''''||'''''''||''|''|'||'''''''|''''''''''''''''''''''''''''''";
					echo "''''''''''''''''''''''''|'''|'|'''''''||'''_'''||'''|_|'||''_____|''''''''''''''''''''''''''''''";
					echo "''''''''''''''''''''''''|'''|'|'''''''||''|'|''||'''''''||'|_____'''''''''''''''''''''''''''''''";
					echo "''''''''''''''''''''''''|'''|'|''''''_||''|_|''||''_''''||_____''|''''''''''''''''''''''''''''''";
					echo "''''''''''''''''''''''''|'''|'|'''''|_'|'''''''||'|'|'''|'_____|'|''''''''''''''''''''''''''''''";
					echo "''''''''''''''''''''''''|___|'|_______||_______||_|''|__||_______|''''''''''''''''''''''''''''''";


firstcount=$(find $dirtemp -type f | wc -l)	
firstcount2=$(find $dirstore -type f | wc -l)
bannercount=$(find $dirbanner -type f | wc -l)		 
sleep 10
wget $get -P $download
wget $getbanner -P $dirbanner
sleep 3
lastcount=$(find $dirtemp -type f | wc -l)	
lastcount2=$(find $dirstore -type f | wc -l)
bannercount2=$(find $dirbanner -type f | wc -l)	
totalnew=$(($lastcount - $firstcount))
totalnew2=$(($lastcount2 - $firstcount2))
bannernew=$(($bannercount2 - $bannercount))


if [[ "$direct_copy_icons" =~ ^(0|1)$ ]]; then


		if [ "$direct_copy_icons" -eq 0 ]; then
			#display message
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''_______''___''''''___''''''''______'''_______''__''''_''_______'''''''''";
			echo "''''''''|'''_'''||'''|''''|'''|''''''|''''''|'|'''''''||''|''|'||'''''''|''''''''";
			echo "''''''''|''|_|''||'''|''''|'''|''''''|''_''''||'''_'''||'''|_|'||''''___|''''''''";
			echo "''''''''|'''''''||'''|''''|'''|''''''|'|'|'''||''|'|''||'''''''||'''|___'''''''''";
			echo "''''''''|'''''''||'''|___'|'''|___'''|'|_|'''||''|_|''||''_''''||''''___|''''''''";
			echo "''''''''|'''_'''||'''''''||'''''''|''|'''''''||'''''''||'|'|'''||'''|___'''''''''";
			echo "''''''''|__|'|__||_______||_______|''|______|'|_______||_|''|__||_______|''''''''";
			echo "'''''''''__''''_''_______''_'''''_''''_______''_______''______''''_______''''''''";
			echo "''''''''|''|''|'||'''''''||'|'_'|'|''|'''''''||'''''''||''''_'|''|'''''''|'''''''";
			echo "''''''''|'''|_|'||'''_'''||'||'||'|''|''_____||'''_'''||'''|'||''|_'''''_|'''''''";
			echo "''''''''|'''''''||''|'|''||'''''''|''|'|_____'|''|'|''||'''|_||_'''|'''|'''''''''";
			echo "''''''''|''_''''||''|_|''||'''''''|''|_____''||''|_|''||''''__''|''|'''|'''''''''";
			echo "''''''''|'|'|'''||'''''''||'''_'''|'''_____|'||'''''''||'''|''|'|''|'''|'''''''''";
			echo "''''''''|_|''|__||_______||__|'|__|''|_______||_______||___|''|_|''|___|'''''''''";
			echo "'__'''__''_______''__'''__''______''''''___'''_______''_______''__''''_''_______'";
			echo "|''|'|''||'''''''||''|'|''||''''_'|''''|'''|'|'''''''||'''''''||''|''|'||'''''''|";
			echo "|''|_|''||'''_'''||''|'|''||'''|'||''''|'''|'|'''''''||'''_'''||'''|_|'||''_____|";
			echo "|'''''''||''|'|''||''|_|''||'''|_||_'''|'''|'|'''''''||''|'|''||'''''''||'|_____'";
			echo "|_'''''_||''|_|''||'''''''||''''__''|''|'''|'|''''''_||''|_|''||''_''''||_____''|";
			echo "''|'''|''|'''''''||'''''''||'''|''|'|''|'''|'|'''''|_'|'''''''||'|'|'''|'_____|'|";
			echo "''|___|''|_______||_______||___|''|_|''|___|'|_______||_______||_|''|__||_______|";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "Sort your icons located at $dirtemp and put the ones you want into $dirstore"
			if [ "$lastcount" -gt "$firstcount" ]; then

						pushnotice "$totalnew new icons downloaded to $dirtemp ready for sorting"



					else
						echo "No new icons downloaded"
						fi



			elif [ "$direct_copy_icons" -eq 1 ]; then
			#rysnc downloaded icons to dynamix.vm.manager/templates/images then display message
			rsync -a $dirstore/* /usr/local/emhttp/plugins/dynamix.vm.manager/templates/images

			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''_______''___''''''___''''''''______'''_______''__''''_''_______'''''''";
			echo "''''''''''|'''_'''||'''|''''|'''|''''''|''''''|'|'''''''||''|''|'||'''''''|''''''";
			echo "''''''''''|''|_|''||'''|''''|'''|''''''|''_''''||'''_'''||'''|_|'||''''___|''''''";
			echo "''''''''''|'''''''||'''|''''|'''|''''''|'|'|'''||''|'|''||'''''''||'''|___'''''''";
			echo "''''''''''|'''''''||'''|___'|'''|___'''|'|_|'''||''|_|''||''_''''||''''___|''''''";
			echo "''''''''''|'''_'''||'''''''||'''''''|''|'''''''||'''''''||'|'|'''||'''|___'''''''";
			echo "''''''''''|__|'|__||_______||_______|''|______|'|_______||_|''|__||_______|''''''";
			echo "'''''''___'''_______''_______''__''''_''_______''''__''''_''_______''_'''''_'''''";
			echo "''''''|'''|'|'''''''||'''''''||''|''|'||'''''''|''|''|''|'||'''''''||'|'_'|'|''''";
			echo "''''''|'''|'|'''''''||'''_'''||'''|_|'||''_____|''|'''|_|'||'''_'''||'||'||'|''''";
			echo "''''''|'''|'|'''''''||''|'|''||'''''''||'|_____'''|'''''''||''|'|''||'''''''|''''";
			echo "''''''|'''|'|''''''_||''|_|''||''_''''||_____''|''|''_''''||''|_|''||'''''''|''''";
			echo "''''''|'''|'|'''''|_'|'''''''||'|'|'''|'_____|'|''|'|'|'''||'''''''||'''_'''|''''";
			echo "''''''|___|'|_______||_______||_|''|__||_______|''|_|''|__||_______||__|'|__|''''";
			echo "'''''''''''''''''''______''''_______''_______''______'''__'''__''''''''''''''''''";
			echo "''''''''''''''''''|''''_'|''|'''''''||'''_'''||''''''|'|''|'|''|'''''''''''''''''";
			echo "''''''''''''''''''|'''|'||''|''''___||''|_|''||''_''''||''|_|''|'''''''''''''''''";
			echo "''''''''''''''''''|'''|_||_'|'''|___'|'''''''||'|'|'''||'''''''|'''''''''''''''''";
			echo "''''''''''''''''''|''''__''||''''___||'''''''||'|_|'''||_'''''_|'''''''''''''''''";
			echo "''''''''''''''''''|'''|''|'||'''|___'|'''_'''||'''''''|''|'''|'''''''''''''''''''";
			echo "''''''''''''''''''|___|''|_||_______||__|'|__||______|'''|___|'''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''";
			echo "              Icons are now ready to use and available in vm manager.            "

			if [ "$lastcount2" -gt "$firstcount2" ]; then

						pushnotice "$totalnew2 new icons downloaded your vm manager"


					else
						echo "No new icons downloaded"
						fi



		fi


	else


		echo "."	


	fi



	if [ "$bannercount2" -gt "$bannercount" ]; then

				pushnotice "$bannernew new banners downloaded to $dirbanner "





			else
				echo "No new banners downloaded"
				fi


exit 0