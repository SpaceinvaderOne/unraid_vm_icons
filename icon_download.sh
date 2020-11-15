# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  Download custom vm icons from github and add them to Unraid server # #
# #  by - SpaceinvaderOne                                               # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  Variables - (other variables set in container template             # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Directory for downloaded icons to be stored
DIR="/icons/icons"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  Functions                                                          # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Delete icon store if present and delete is set to yes in template
deletedirectories() {
	if [ -d $DIR ] && [ $delete == "yes" ]; then
		
	rm -r $DIR
	echo "I have deleted the icon directories ready for new"
    echo "."
    echo "."
else
	echo "  ......continuing."
    echo "."
    echo "."

	fi			
		

}

# Create icon directory if not present if directory exists sync contents to vm manger and exit
createorsync() {
	if [ ! -d $DIR ] ; then
		
	mkdir -vp $DIR
	echo "I have created the icon directories now will start downloading selected icons"
	downloadwindows
	downloadlinux
	downloadfreebsd
	downloadother
	downloadmacos
    echo "."
    echo "."
	echo "icons downloaded and synced"
else
	rsync -a $DIR/* /unraid_vm_icons
    echo "."
    echo "."
	echo "Icons downloaded previously."
	echo "icons synced"

	fi			
		

}

# Download windows based OS icons if set in template
downloadwindows() {
    if [ $windows == "yes" ] ; then
	get="-r -c -S -N -nH -e robots=off -nd -np -A png -R index.html* https://raw.githubusercontent.com/SpaceinvaderOne/unraid_vm_icons/master/icons/Windows/"
    wget $get -P $DIR
			else
				echo "  windows based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download linux based OS icons if set in template
downloadlinux() {
    if [ $linux == "yes" ] ; then
	#set wget to download all linux based os icons
	get2="-r -c -S -N -nH -e robots=off -nd -np -A png -R index.html* https://raw.githubusercontent.com/SpaceinvaderOne/unraid_vm_icons/master/icons/Linux/"
    wget $get2 -P $DIR
			else
				echo "  linux based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}


# Download freebsd based OS icons if set in template
downloadfreebsd() {
    if [ $freebsd == "yes" ] ; then
	#set wget to download all freebsd based os icons
	get3="-r -c -S -N -nH -e robots=off -nd -np -A png -R index.html* https://raw.githubusercontent.com/SpaceinvaderOne/unraid_vm_icons/master/icons/Freebsd/"
    wget $get3 -P $DIR
			else
				echo "  freebsd based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download other OS icons if set in template
downloadother() {
    if [ $other == "yes" ] ; then
	#set wget to download all other os icons
	get4="-r -c -S -N -nH -e robots=off -nd -np -A png -R index.html* https://raw.githubusercontent.com/SpaceinvaderOne/unraid_vm_icons/master/icons/Other/"
    wget $get4 -P $DIR
			else
				echo "  other os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download macOS based OS icons if set in template
downloadmacos() {
    if [ $macos == "yes" ] ; then
	#set wget to download all windows based os icons
	get5="-r -c -S -N -nH -e robots=off -nd -np -A png -R index.html* https://raw.githubusercontent.com/SpaceinvaderOne/unraid_vm_icons/master/icons/macOS/"
    wget $get5 -P $DIR
			else
				echo "  macos based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}



deletedirectories
createorsync


