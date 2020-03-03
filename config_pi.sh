#!
# include file by the my.... command series (post installation scripts)
#

DOWNLOAD_DIR="/tmp/"
#MY_PROG=$(basename $0 .sh)
MY_PROG=DC_LangueFR_Pi
GUI=""

# Set language with given parameter
if [ "X$1" != "X" ]
then
	LANG=$1
fi

# Langue ## Uniquement en FR pour l'instant.
f_get_msg(){
	no_msg_file="Erreur : fichier non trouvé ou problème de permission d'accès !"
	lang=${LANG:=english}
	case ${lang} in
		[Ee][Nn][Gg]*	)	all_msg=${MY_DIR}/${MY_PROG}.fr 
							DOWNLOAD_DIR=~/Downloads/;;
		[Ff][Rr]*	)	all_msg=${MY_DIR}/${MY_PROG}.fr 
						DOWNLOAD_DIR=~/Téléchargements/;;
		*			)	all_msg=${MY_DIR}/${MY_PROG}.fr
						DOWNLOAD_DIR=~/Downloads/;;
	esac
	if [ -f ${all_msg} -a -r ${all_msg} ]
	then
		. ${all_msg}
	else
		echo ${no_msg_file}
		exit 3
	fi
}

# Run Action $1 with command $2 and display notification $3, if given
f_action_exec() {
	if [[ "$GUI" = *"$1"* ]]
	then
		if [ "X$3" = "X" ]
		then
			ns_exec="$NS_INSTALL $1"
		else
			ns_exec="$3"
		fi
		echo $ns_exec " ..."
		echo ""
		notify-send -i system-software-update "$MY_PROG" "$ns_exec" -t 5000
		bash -c "$2"
	fi
}

# Run Action $1 by installing $2 and display notification
f_action_install() {
	if [[ "$GUI" == *"$1"* ]]
	then
		echo "$NS_INSTALL $1 ..."
		echo ""
		notify-send -i system-software-update "$MY_PROG" "$NS_INSTALL $1" -t 5000
		sudo pacman -S $2 --noconfirm
	fi
}

# Installation via AUR
f_action_aur_install() {
	if [[ "$GUI" == *"$1"* ]]
	then
		echo "$NS_INSTALL $1 ..."
		echo ""
		notify-send -i system-software-update "$MY_PROG" "$NS_INSTALL $1" -t 5000
		yay -S $2 --noconfirm
	fi
}

# Récupération de paquet universel portable au format AppImage (+ ajout du droit d'execution)
f_action_get_appimage() {
	if [[ "$GUI" == *"$1"* ]]
	then
		echo "$NS_INSTALL $1 ..."
		echo ""
		notify-send -i system-software-update "$MY_PROG" "$NS_INSTALL $1" -t 2000
		cd $DOWNLOAD_DIR
	    if [ ! -d $HOME/AppImage ]
	    then
	        mkdir $HOME/AppImage  
	    fi
		wget "$2" --no-check-certificate
		chmod +x *.?pp?mage && mv *.?pp?mage $HOME/AppImage/
	fi
}

# Installation de paquet Snap
f_action_snap_install() {
	if [[ "$GUI" == *"$1"* ]]
	then
	    # Vérification que Snap est bien installé et l'installer si ce n'est pas le cas (uniquement si un paquet Snap est demandé !)
	    if [ ! -f /usr/bin/snap ]  # si snap non installé (en cas d'install de logiciel snap explicitement demandé par l'utilisateur
	    then
	        if [ ! -f /etc/manjaro-release ]  # Si pas manjaro, alors installé via AUR 
	        then
	            yay -S snapd --noconfirm  
	        else # Sinon (si ArchLinux)
	            sudo pacman -S snapd --noconfirm
	        fi
	    fi
		echo  "$NS_DEFERED $1 ..."
		echo ""
		ALL_SNAP_NS="${ALL_SNAP_NS} $1"
		sudo snap install $2
		ALL_SNAP_INSTALL="${ALL_SNAP_INSTALL} $3"
	fi
}

# Installation flatpk
f_action_flatpak_install() {
	if [[ "$GUI" == *"$1"* ]]
	then
	    # Vérification que Flatpak est bien installé et l'installer si ce n'est pas le cas (uniquement si un paquet Flatpak est demandé !)
	    if [ ! -f /usr/bin/flatpak ]
	    then
	        sudo apt install flatpak -y
	        sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # Ajout du dépot Flathub
	    fi
		echo  "$NS_DEFERED $1 ..."
		echo ""
		ALL_FLATPAK_NS="${ALL_FLATPAK_NS} $1"
		flatpak install flathub $2 -y
		ALL_FLATPAK_INSTALL="${ALL_FLATPAK_INSTALL} $3"
	fi
}


#send back TRUE/FALSE according the choice defined in $CHK_REP, and the default value given in $1
chkDef() {
	case "$CHK_REP" in
		"$BGN_DEF") echo -n "$1" ;;
		"$BGN_CHECKED") echo -n "TRUE";;
		"$BGN_UNCHECKED") echo -n "FALSE";;
	esac
}

# Clear the Terminal
#clear

#Install tools for the script
which zenity > /dev/null
if [ $? = 1 ]
then
	sudo pacman -S zenity --noconfirm
fi

which notify-send > /dev/null
if [ $? = 1 ]
then
	sudo pacman -S libnotify --noconfirm
fi

which curl > /dev/null
if [ $? = 1 ]
then
	sudo pacman -S curl --noconfirm
fi

which git > /dev/null
if [ $? = 1 ]
then
	sudo pacman -S git --noconfirm
fi

which yay > /dev/null
if [ $? = 1 ]
then
    git clone https://aur.archlinux.org/yay.git ; cd yay ; makepkg -si --noconfirm #("Go" sera installé en dépendance)
    cd .. && rm -rf yay
fi

which unzip > /dev/null
if [ $? = 1 ]
then
    sudo pacman -S unzip --noconfirm
fi

which wget > /dev/null
if [ $? = 1 ]
then
    sudo pacman -S wget --noconfirm
fi

#Get Language message
f_get_msg

notify-send  --icon=dialog-error "$NS_WATCH_OUT" "$NS_PWD_ASKED" -t 4000
