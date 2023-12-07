# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  Download custom vm icons from github and add them to Unraid server # #
# #  by - SpaceinvaderOne                                               # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  Variables - (other variables set in container template             # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Directory for downloaded icons to be stored
DIR="/config/icons"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  Functions                                                          # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Delete icon store if present and delete if set to yes in template
shall_i_delete() {
	#check if icon store exists and delete it if clear icons flag is set
	if [ -d $DIR ] && [ $delete == "yes" ]; then
		
	rm -r $DIR
	echo "I have deleted all vm icons ready to download fresh icons to sync"
    echo "."
    echo "."
else
	#do nothing and continue of clear icons flag is not set
	echo "  Clear all icons not set......continuing."

	fi					

}

checkgit() {
	
	# delete directory if previously run so can do fresh gitclone
	if [ -d /config/unraid_vm_icons ] ; then
    rm -r /config/unraid_vm_icons
    fi
	#run gitclone
git -C /config clone https://github.com/SpaceinvaderOne/unraid_vm_icons.git				
}

# Create icon directory if not present then download selected icons. Skip if already done
downloadicons() {
	if [ ! -d $DIR ] ; then
		
	mkdir -vp $DIR
	echo "I have created the icon store directory & now will start downloading selected icons"
    checkgit
	downloadstock
	downloadwindows
	downloadlinux
	downloadfreebsd
	downloadother
	downloadmacos
    echo "."
    echo "."
	echo "icons downloaded"
else
	
    echo "."
    echo "."
	echo "Icons downloaded previously."
	

	fi
			
}

# Sync icons in icon store to vm manager
syncicons() {
	#make sure at least one file exists before trying to delete
	touch /unraid_vm_icons/windowsxp.png
	#delete all existing icons in vm manager
	rm /unraid_vm_icons/*.*	
	#sync all icons selected to vm manager
	rsync -a $DIR/ /unraid_vm_icons/
	#reset permissions of appdata folder
	chmod 777 -R /config/
	#print message
    echo "icons synced"
	#play a tune if set
	playtune	
}

# Keep stock Unraid VM icons if set in template
downloadstock() {
    if [ $stock == "yes" ] ; then
	rsync -a /config/unraid_vm_icons/icons/Stock_Icons/ $DIR/
			else
				echo "  unraid stock icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download windows based OS icons if set in template
downloadwindows() {
    if [ $windows == "yes" ] ; then
	rsync -a /config/unraid_vm_icons/icons/Windows/ $DIR/
			else
				echo "  windows based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download linux based OS icons if set in template
downloadlinux() {
    if [ $linux == "yes" ] ; then
    rsync -a /config/unraid_vm_icons/icons/Linux/ $DIR/
			else
				echo "  linux based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}


# Download freebsd based OS icons if set in template
downloadfreebsd() {
    if [ $freebsd == "yes" ] ; then
	rsync -a /config/unraid_vm_icons/icons/Freebsd/ $DIR/
			else
				echo "  freebsd based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download other OS icons if set in template
downloadother() {
    if [ $other == "yes" ] ; then
	rsync -a /config/unraid_vm_icons/icons/Other/ $DIR/
			else
				echo "  other os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download macOS based OS icons if set in template
downloadmacos() {
    if [ $macos == "yes" ] ; then
	rsync -a /config/unraid_vm_icons/icons/macOS/ $DIR/
			else
				echo "  macos based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Play tune on sync through beep speaker
playtune() {
    if [ $tune == "yes" ] ; then

beep -f 195 -l 137 -D 0 -n -f 261 -l 138 -D 0 -n -f 329 -l 137 -D 0 -n -f 391 -l 137 -D 0 -n -f 523 -l 138 -D 0 -n -f 659 -l 137 -D 0 -n -f 783 -l 413 -D 0 -n -f 659 -l 413 -D 1 -n -f 207 -l 136 -D 0 -n -f 207 -l 10 -D 0 -n -f 261 -l 10 -D 0 -n -f 261 -l 130 -D 0 -n -f 311 -l 137 -D 0 -n -f 415 -l 137 -D 0 -n -f 523 -l 138 -D 0 -n -f 622 -l 137 -D 0 -n -f 830 -l 413 -D 0 -n -f 622 -l 413 -D 0 -n -f 233 -l 137 -D 0 -n -f 293 -l 138 -D 0 -n -f 349 -l 137 -D 0 -n -f 466 -l 137 -D 0 -n -f 587 -l 138 -D 0 -n -f 698 -l 137 -D 0 -n -f 932 -l 413 -n -f 932 -l 137 -r 3 -D 0 -n -f 1046 -l 827

fi
}

# set time before exiting container
exit_time() {
    if [ "$sleeptimehuman" == "30 seconds" ] ; then
	sleeptime=30
fi
    if [ "$sleeptimehuman" == "1 minute" ] ; then
	sleeptime=60
fi
    if [ "$sleeptimehuman" == "2 minutes" ] ; then
	sleeptime=120
fi
    if [ "$sleeptimehuman" == "5 minutes" ] ; then
	sleeptime=300
fi
    if [ "$sleeptimehuman" == "10 minutes" ] ; then
	sleeptime=600
fi

sleep $sleeptime


}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  run functions                                                      # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

shall_i_delete
downloadicons
syncicons
exit_time


