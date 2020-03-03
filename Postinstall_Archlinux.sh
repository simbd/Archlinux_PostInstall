#!/bin/bash
# v3.0.0
# Script de post-installation pour Archlinux

# Code couleur
rouge='\e[1;31m'
jaune='\e[1;33m' 
bleu='\e[1;34m' 
violet='\e[1;35m' 
vert='\e[1;32m'
neutre='\e[0;m'

# Vérification que le script n'est pas lancé directement avec sudo (le script contient déjà les sudos pour les actions lorsque c'est nécessaire)
if [ "$UID" -eq "0" ]
then
    echo -e "${rouge}Merci de ne pas lancer directement ce script avec les droits root : lancez le sans sudo (./Postinstall_Archlinux.sh), le mot de passe sera demandé dans le terminal lors de la 1ère action nécessitant le droit administrateur.${neutre}"
    exit
fi

MY_DIR=$(dirname $0)
. $MY_DIR/config_pi.sh

CHK_REP=$(zenity --entry --title="$BGN_TITLE" --text "$BGN_TEXT" --entry-text="$BGN_DEF" $BGN_CHECKED $BGN_UNCHECKED)
if [ $? -ne 0 ] ; then
	exit
fi

# Zenity
GUI=$(zenity --list --checklist --height 700 --width 950 \
	--title="$MSG_ZEN_TITLE" --text="$MSG_ZEN_TEXT" \
	--column="$MSG_ZEN_CHECK" --column="$MSG_ZEN_ACTION" --column="$MSG_ZEN_DESCRIPTION" \
	$(chkDef "TRUE") "$CA_UPGRADE" "$CD_UPGRADE" \
	FALSE "$SCT_BROWSER" "===========================================================" \
    $(chkDef "FALSE") "$CA_BEAKER" "$CD_BEAKER" \
    $(chkDef "FALSE") "$CA_BRAVE" "$CD_BRAVE" \
    $(chkDef "TRUE") "$CA_CHROMIUM" "$CD_CHROMIUM" \
    $(chkDef "FALSE") "$CA_DILLO" "$CD_DILLO" \
    $(chkDef "FALSE") "$CA_EOLIE" "$CD_EOLIE" \
    $(chkDef "FALSE") "$CA_FALKON" "$CD_FALKON" \
    $(chkDef "TRUE") "$CA_FIREFOX" "$CD_FIREFOX" \
    $(chkDef "FALSE") "$CA_FIREFOXBETA" "$CD_FIREFOXBETA" \
    $(chkDef "FALSE") "$CA_FIREFOXDEV" "$CD_FIREFOXDEV" \
    $(chkDef "FALSE") "$CA_FIREFOXESR" "$CD_FIREFOXESR" \
    $(chkDef "FALSE") "$CA_FIREFOXNIGHTLY" "$CD_FIREFOXNIGHTLY" \
    $(chkDef "FALSE") "$CA_EPIPHANY" "$CD_EPIPHANY" \
    $(chkDef "FALSE") "$CA_CHROME" "$CD_CHROME" \
    $(chkDef "FALSE") "$CA_LYNX" "$CD_LYNX" \
    $(chkDef "FALSE") "$CA_MIDORI" "$CD_MIDORI" \
    $(chkDef "FALSE") "$CA_MIN" "$CD_MIN" \
    $(chkDef "FALSE") "$CA_OPERA" "$CD_OPERA" \
    $(chkDef "FALSE") "$CA_TORBROWSER" "$CD_TORBROWSER" \
    $(chkDef "FALSE") "$CA_VIVALDI" "$CD_VIVALDI" \
	FALSE "$SCT_INTERNET" "===========================================================" \
	$(chkDef "FALSE") "$CA_AMULE" "$CD_AMULE" \
	$(chkDef "FALSE") "$CA_CLUSTERSSH" "$CD_CLUSTERSSH" \
	$(chkDef "FALSE") "$CA_DELUGE" "$CD_DELUGE" \
	$(chkDef "FALSE") "$CA_DISCORD" "$CD_DISCORD" \
	$(chkDef "FALSE") "$CA_DUKTO" "$CD_DUKTO" \
	$(chkDef "FALSE") "$CA_EMPATHY" "$CD_EMPATHY" \
	$(chkDef "TRUE") "$CA_FILEZILLA" "$CD_FILEZILLA" \
	$(chkDef "FALSE") "$CA_FROSTWIRE" "$CD_FROSTWIRE" \
	$(chkDef "FALSE") "$CA_HEXCHAT" "$CD_HEXCHAT" \
	$(chkDef "FALSE") "$CA_HUBIC" "$CD_HUBIC" \
	$(chkDef "FALSE") "$CA_MUMBLE" "$CD_MUMBLE" \
	$(chkDef "FALSE") "$CA_NICOTINE" "$CD_NICOTINE" \
	$(chkDef "TRUE") "$CA_PIDGIN" "$CD_PIDGIN" \
	$(chkDef "FALSE") "$CA_POLARI" "$CD_POLARI" \
	$(chkDef "FALSE") "$CA_PSI" "$CD_PSI" \
	$(chkDef "FALSE") "$CA_QARTE" "$CD_QARTE" \
	$(chkDef "FALSE") "$CA_QBITTORRENT" "$CD_QBITTORRENT" \
	$(chkDef "FALSE") "$CA_RDESKTOP" "$CD_RDESKTOP" \
	$(chkDef "FALSE") "$CA_RING" "$CD_RING" \
	$(chkDef "FALSE") "$CA_RIOT" "$CD_RIOT" \
	$(chkDef "FALSE") "$CA_SIGNAL" "$CD_SIGNAL" \
	$(chkDef "FALSE") "$CA_SKYPE" "$CD_SKYPE" \
	$(chkDef "FALSE") "$CA_SLACK" "$CD_SLACK" \
	$(chkDef "FALSE") "$CA_SUBDOWNLOADER" "$CD_SUBDOWNLOADER" \
	$(chkDef "FALSE") "$CA_TEAMSPEAK" "$CD_TEAMSPEAK" \
	$(chkDef "FALSE") "$CA_TELEGRAM" "$CD_TELEGRAM" \
	$(chkDef "FALSE") "$CA_UGET" "$CD_UGET" \
	$(chkDef "FALSE") "$CA_VUZE" "$CD_VUZE" \
	$(chkDef "FALSE") "$CA_WEECHAT" "$CD_WEECHAT" \
	$(chkDef "FALSE") "$CA_WHALEBIRD" "$CD_WHALEBIRD" \
	$(chkDef "FALSE") "$CA_WHATSAPP" "$CD_WHATSAPP" \
	$(chkDef "FALSE") "$CA_WIRE" "$CD_WIRE" \
	FALSE "$SCT_LECTUREMULTIMEDIA" "===========================================================" \
	$(chkDef "FALSE") "$CA_AUDACIOUS" "$CD_AUDACIOUS" \
	$(chkDef "FALSE") "$CA_BANSHEE" "$CD_BANSHEE" \
	$(chkDef "FALSE") "$CA_CANTATA" "$CD_CANTATA" \
	$(chkDef "FALSE") "$CA_CLEMENTINE" "$CD_CLEMENTINE" \
	$(chkDef "FALSE") "$CA_DEEZLOADER" "$CD_DEEZLOADER" \
	$(chkDef "FALSE") "$CA_FLASH" "$CD_FLASH" \
	$(chkDef "FALSE") "$CA_GMUSICBROWSER" "$CD_GMUSICBROWSER" \
	$(chkDef "TRUE") "$CA_GNOMEMPV" "$CD_GNOMEMPV" \
	$(chkDef "FALSE") "$CA_GNOMEMUSIC" "$CD_GNOMEMUSIC" \
	$(chkDef "FALSE") "$CA_GNOMETWITCH" "$CD_GNOMETWITCH" \
	$(chkDef "FALSE") "$CA_GRADIO" "$CD_GRADIO" \
	$(chkDef "FALSE") "$CA_LOLLYPOP" "$CD_LOLLYPOP" \
	$(chkDef "FALSE") "$CA_MOLOTOVTV" "$CD_MOLOTOVTV" \
	$(chkDef "FALSE") "$CA_PAVUCONTROL" "$CD_PAVUCONTROL" \
	$(chkDef "FALSE") "$CA_QMMP" "$CD_QMMP" \
	$(chkDef "FALSE") "$CA_QUODLIBET" "$CD_QUODLIBET" \
	$(chkDef "FALSE") "$CA_RHYTHMBOX" "$CD_RHYTHMBOX" \
	$(chkDef "FALSE") "$CA_SHOTWELL" "$CD_SHOTWELL" \
	$(chkDef "FALSE") "$CA_SMPLAYER" "$CD_SMPLAYER" \
	$(chkDef "FALSE") "$CA_SPOTIFY" "$CD_SPOTIFY" \
	$(chkDef "TRUE") "$CA_VLCSTABLE" "$CD_VLCSTABLE" \
	$(chkDef "FALSE") "$CA_VLCDEV" "$CD_VLCDEV" \
	FALSE "$SCT_MONTAGEMULTIMEDIA" "===========================================================" \
	$(chkDef "FALSE") "$CA_ARDOUR" "$CD_ARDOUR" \
	$(chkDef "FALSE") "$CA_AUDACITY" "$CD_AUDACITY" \
	$(chkDef "FALSE") "$CA_AVIDEMUX" "$CD_AVIDEMUX" \
	$(chkDef "FALSE") "$CA_BLENDER" "$CD_BLENDER" \
	$(chkDef "FALSE") "$CA_CINELERRA" "$CD_CINELERRA" \
	$(chkDef "FALSE") "$CA_DARKTABLE" "$CD_DARKTABLE" \
	$(chkDef "FALSE") "$CA_EASYTAG" "$CD_EASYTAG" \
	$(chkDef "FALSE") "$CA_FLACON" "$CD_FLACON" \
	$(chkDef "FALSE") "$CA_FLAMESHOT" "$CD_FLAMESHOT" \
	$(chkDef "FALSE") "$CA_FLOWBLADE" "$CD_FLOWBLADE" \
	$(chkDef "FALSE") "$CA_FREECAD" "$CD_FREECAD" \
	$(chkDef "FALSE") "$CA_GIADA" "$CD_GIADA" \
	$(chkDef "TRUE") "$CA_GIMP" "$CD_GIMP" \
	$(chkDef "FALSE") "$CA_GNOMESOUNDRECORDER" "$CD_GNOMESOUNDRECORDER" \
	$(chkDef "TRUE") "$CA_HANDBRAKE" "$CD_HANDBRAKE" \
	$(chkDef "FALSE") "$CA_HYDROGEN" "$CD_HYDROGEN" \
	$(chkDef "FALSE") "$CA_IMCOMPRESSOR" "$CD_IMCOMPRESSOR" \
	$(chkDef "FALSE") "$CA_INKSCAPE" "$CD_INKSCAPE" \
	$(chkDef "FALSE") "$CA_KAZAM" "$CD_KAZAM" \
	$(chkDef "FALSE") "$CA_KDENLIVE" "$CD_KDENLIVE" \
	$(chkDef "FALSE") "$CA_KOLOURPAINT" "$CD_KOLOURPAINT" \
	$(chkDef "FALSE") "$CA_KRITA" "$CD_KRITA" \
	$(chkDef "FALSE") "$CA_LEOCAD" "$CD_LEOCAD" \
	$(chkDef "FALSE") "$CA_LIGHTWORKS" "$CD_LIGHTWORKS" \
	$(chkDef "FALSE") "$CA_LIBRECAD" "$CD_LIBRECAD" \
	$(chkDef "FALSE") "$CA_LIVES" "$CD_LIVES" \
	$(chkDef "FALSE") "$CA_LUMINANCE" "$CD_LUMINANCE" \
	$(chkDef "FALSE") "$CA_LMMS" "$CD_LMMS" \
	$(chkDef "FALSE") "$CA_MHWAVEEDIT" "$CD_MHWAVEEDIT" \
	$(chkDef "FALSE") "$CA_MIXXX" "$CD_MIXXX" \
	$(chkDef "FALSE") "$CA_MUSESCORE" "$CD_MUSESCORE" \
	$(chkDef "FALSE") "$CA_MYPAINT" "$CD_MYPAINT" \
	$(chkDef "FALSE") "$CA_NATRON" "$CD_NATRON" \
	$(chkDef "FALSE") "$CA_OBS" "$CD_OBS" \
	$(chkDef "FALSE") "$CA_OLIVE" "$CD_OLIVE" \
	$(chkDef "TRUE") "$CA_OPENSHOT" "$CD_OPENSHOT" \
	$(chkDef "FALSE") "$CA_PEEK" "$CD_PEEK" \
	$(chkDef "FALSE") "$CA_PINTA" "$CD_PINTA" \
	$(chkDef "FALSE") "$CA_PITIVI" "$CD_PITIVI" \
	$(chkDef "FALSE") "$CA_PIXELUVO" "$CD_PIXELUVO" \
	$(chkDef "FALSE") "$CA_RAWTHERAPEE" "$CD_RAWTHERAPEE" \
	$(chkDef "FALSE") "$CA_ROSEGARDEN" "$CD_ROSEGARDEN" \
    $(chkDef "FALSE") "$CA_SHOTCUT" "$CD_SHOTCUT" \
	$(chkDef "FALSE") "$CA_SHUTTER" "$CD_SHUTTER" \
	$(chkDef "FALSE") "$CA_SIMPLESCREENRECORDER" "$CD_SIMPLESCREENRECORDER" \
	$(chkDef "FALSE") "$CA_SOUNDJUICER" "$CD_SOUNDJUICER" \
	$(chkDef "FALSE") "$CA_SWEETHOME" "$CD_SWEETHOME" \
	$(chkDef "FALSE") "$CA_SYNFIG" "$CD_SYNFIG" \
	$(chkDef "FALSE") "$CA_UNITY3DEDITOR" "$CD_UNITY3DEDITOR" \
	$(chkDef "FALSE") "$CA_VIDCUTTER" "$CD_VIDCUTTER" \
	$(chkDef "FALSE") "$CA_VOKOSCREEN" "$CD_VOKOSCREEN" \
	$(chkDef "FALSE") "$CA_WINFF" "$CD_WINFF" \
	$(chkDef "FALSE") "$CA_XNVIEW" "$CD_XNVIEW" \
	FALSE "$SCT_OFFICE" "===========================================================" \
	$(chkDef "FALSE") "$CA_BOOSTNOTE" "$CD_BOOSTNOTE" \
	$(chkDef "FALSE") "$CA_CALLIGRA" "$CD_CALLIGRA" \
	$(chkDef "FALSE") "$CA_FRDIC" "$CD_FRDIC" \
	$(chkDef "FALSE") "$CA_FBREADER" "$CD_FBREADER" \
	$(chkDef "FALSE") "$CA_FEEDREADER" "$CD_FEEDREADER" \
	$(chkDef "FALSE") "$CA_FREEOFFICE" "$CD_FREEOFFICE" \
	$(chkDef "FALSE") "$CA_FREEPLANE" "$CD_FREEPLANE" \
	$(chkDef "FALSE") "$CA_GEARY" "$CD_GEARY" \
	$(chkDef "FALSE") "$CA_EVOLUTION" "$CD_EVOLUTION" \
	$(chkDef "FALSE") "$CA_GNOMEOFFICE" "$CD_GNOMEOFFICE" \
	$(chkDef "FALSE") "$CA_GRAMPS" "$CD_GRAMPS" \
	$(chkDef "TRUE") "$CA_LIBREOFFICEFRESH" "$CD_LIBREOFFICEFRESH" \
	$(chkDef "FALSE") "$CA_LIBREOFFICESTILL" "$CD_LIBREOFFICESTILL" \
	$(chkDef "FALSE") "$CA_MAILSPRING" "$CD_MAILSPRING" \
	$(chkDef "FALSE") "$CA_MASTERPDFEDITOR" "$CD_MASTERPDFEDITOR" \
	$(chkDef "FALSE") "$CA_NOTESUP" "$CD_NOTESUP" \
	$(chkDef "FALSE") "$CA_ONLYOFFICE" "$CD_ONLYOFFICE" \
	$(chkDef "FALSE") "$CA_OPENOFFICE" "$CD_OPENOFFICE" \
	$(chkDef "FALSE") "$CA_PDFMOD" "$CD_PDFMOD" \
	$(chkDef "FALSE") "$CA_PDFSAM" "$CD_PDFSAM" \
	$(chkDef "TRUE") "$CA_POLICEMST" "$CD_POLICEMST" \
	$(chkDef "FALSE") "$CA_SCRIBUS" "$CD_SCRIBUS" \
	$(chkDef "TRUE") "$CA_THUNDERBIRD" "$CD_THUNDERBIRD" \
	$(chkDef "FALSE") "$CA_WPSOFFICE" "$CD_WPSOFFICE" \
	$(chkDef "FALSE") "$CA_XPAD" "$CD_XPAD" \
	$(chkDef "FALSE") "$CA_ZIM" "$CD_ZIM" \
	FALSE "$SCT_EDUSCIENCE" "===========================================================" \
	$(chkDef "FALSE") "$CA_ALGOBOX" "$CD_ALGOBOX" \
	$(chkDef "FALSE") "$CA_AVOGADRO" "$CD_AVOGADRO" \
	$(chkDef "FALSE") "$CA_CELESTIA" "$CD_CELESTIA" \
	$(chkDef "FALSE") "$CA_CONVERTALL" "$CD_CONVERTALL" \
	$(chkDef "FALSE") "$CA_GANTTPROJECT" "$CD_GANTTPROJECT" \
	$(chkDef "FALSE") "$CA_GCOMPRIS" "$CD_GCOMPRIS" \
	$(chkDef "FALSE") "$CA_GELEMENTAL" "$CD_GELEMENTAL" \
	$(chkDef "FALSE") "$CA_GEOGEBRA" "$CD_GEOGEBRA" \
	$(chkDef "FALSE") "$CA_GNOMEMAPS" "$CD_GNOMEMAPS" \
	$(chkDef "FALSE") "$CA_GOOGLEEARTH" "$CD_GOOGLEEARTH" \
	$(chkDef "FALSE") "$CA_GPREDICT" "$CD_GPREDICT" \
	$(chkDef "FALSE") "$CA_JOSM" "$CD_JOSM" \
	$(chkDef "FALSE") "$CA_KICAD" "$CD_KICAD" \
	$(chkDef "FALSE") "$CA_MARBLE" "$CD_MARBLE" \
	$(chkDef "FALSE") "$CA_MBLOCK" "$CD_MBLOCK" \
	$(chkDef "FALSE") "$CA_OPENBOARD" "$CD_OPENBOARD" \
	$(chkDef "FALSE") "$CA_PLANNER" "$CD_PLANNER" \
	$(chkDef "FALSE") "$CA_SCILAB" "$CD_SCILAB" \
	$(chkDef "FALSE") "$CA_STELLARIUM" "$CD_STELLARIUM" \
	$(chkDef "FALSE") "$CA_XCAS" "$CD_XCAS" \
	FALSE "$SCT_UTILITAIRES_GRAPHIQUE" "===========================================================" \
	$(chkDef "FALSE") "$CA_ANYDESK" "$CD_ANYDESK" \
    $(chkDef "FALSE") "$CA_BRASERO" "$CD_BRASERO" \
    $(chkDef "FALSE") "$CA_CHEESE" "$CD_CHEESE" \
    $(chkDef "FALSE") "$CA_DEJADUP" "$CD_DEJADUP" \
    $(chkDef "FALSE") "$CA_DIODON" "$CD_DIODON" \
    $(chkDef "FALSE") "$CA_DOSBOX" "$CD_DOSBOX" \
    $(chkDef "FALSE") "$CA_ELECTRUM" "$CD_ELECTRUM" \
    $(chkDef "FALSE") "$CA_ETHEREUMWALLET" "$CD_ETHEREUMWALLET" \
    $(chkDef "FALSE") "$CA_GNOMEBOXES" "$CD_GNOMEBOXES" \
    $(chkDef "TRUE") "$CA_GNOME_DISK" "$CD_GNOME_DISK" \
    $(chkDef "FALSE") "$CA_GNOMERECIPES" "$CD_GNOMERECIPES" \
    $(chkDef "TRUE") "$CA_GSYSLOG" "$CD_GSYSLOG" \
    $(chkDef "TRUE") "$CA_GSYSMON" "$CD_GSYSMON" \
    $(chkDef "TRUE") "$CA_GPARTED" "$CD_GPARTED" \
    $(chkDef "FALSE") "$CA_JRE8" "$CD_JRE8" \
    $(chkDef "FALSE") "$CA_JRE11" "$CD_JRE11" \
    $(chkDef "FALSE") "$CA_MELD" "$CD_MELD" \
    $(chkDef "FALSE") "$CA_MULTISYSTEM" "$CD_MULTISYSTEM" \
    $(chkDef "FALSE") "$CA_ARCHIVAGE" "$CD_ARCHIVAGE" \
    $(chkDef "FALSE") "$CA_POL" "$CD_POL" \
    $(chkDef "FALSE") "$CA_PUTTY" "$CD_PUTTY" \
    $(chkDef "FALSE") "$CA_QEMUKVM" "$CD_QEMUKVM" \
    $(chkDef "FALSE") "$CA_REDSHIFT" "$CD_REDSHIFT" \
    $(chkDef "FALSE") "$CA_SPEEDCRUNCH" "$CD_SPEEDCRUNCH" \
    $(chkDef "TRUE") "$CA_REMMINA" "$CD_REMMINA" \
    $(chkDef "FALSE") "$CA_SUBLIM_NAUT" "$CD_SUBLIM_NAUT" \
    $(chkDef "FALSE") "$CA_SUB_EDIT" "$CD_SUB_EDIT" \
    $(chkDef "FALSE") "$CA_TEAMVIEWER" "$CD_TEAMVIEWER" \
    $(chkDef "FALSE") "$CA_TERMINATOR" "$CD_TERMINATOR" \
    $(chkDef "FALSE") "$CA_TILIX" "$CD_TILIX" \
    $(chkDef "FALSE") "$CA_TIMESHIFT" "$CD_TIMESHIFT" \
    $(chkDef "FALSE") "$CA_VARIETY" "$CD_VARIETY" \
    $(chkDef "FALSE") "$CA_VBOXDEPOT" "$CD_VBOXDEPOT" \
    $(chkDef "FALSE") "$CA_VMWARE" "$CD_VMWARE" \
    $(chkDef "FALSE") "$CA_WINE" "$CD_WINE" \
    $(chkDef "FALSE") "$CA_X2GO" "$CD_X2GO" \
    $(chkDef "FALSE") "$CA_X11VNC" "$CD_X11VNC" \
	FALSE "$SCT_UTILITAIRES_CLI" "===========================================================" \
    $(chkDef "FALSE") "$CA_DDRESCUE" "$CD_DDRESCUE" \
	$(chkDef "FALSE") "$CA_FD" "$CD_FD" \
	$(chkDef "TRUE") "$CA_HTOP" "$CD_HTOP" \
	$(chkDef "FALSE") "$CA_GLANCES" "$CD_GLANCES" \
	$(chkDef "FALSE") "$CA_LAME" "$CD_LAME" \
	$(chkDef "FALSE") "$CA_HG" "$CD_HG" \
	$(chkDef "TRUE") "$CA_PACKOUTILS" "$CD_PACKOUTILS" \
	$(chkDef "FALSE") "$CA_POWERSHELL" "$CD_POWERSHELL" \
	$(chkDef "FALSE") "$CA_RIPGREP" "$CD_RIPGREP" \
	$(chkDef "FALSE") "$CA_RTORRENT" "$CD_RTORRENT" \
	$(chkDef "FALSE") "$CA_SMARTMONTOOLS" "$CD_SMARTMONTOOLS" \
	$(chkDef "FALSE") "$CA_SPEEDTEST" "$CD_SPEEDTEST" \
	$(chkDef "FALSE") "$CA_TESTDISK" "$CD_TESTDISK" \
	$(chkDef "FALSE") "$CA_TLDR" "$CD_TLDR" \
	$(chkDef "FALSE") "$CA_WORDGRINDER" "$CD_WORDGRINDER" \
	$(chkDef "FALSE") "$CA_YTDLND" "$CD_YTDLND" \
	FALSE "$SCT_RESEAUSECURITE" "===========================================================" \
	$(chkDef "FALSE") "$CA_ANSIBLE" "$CD_ANSIBLE" \
	$(chkDef "FALSE") "$CA_BITWARDEN" "$CD_BITWARDEN" \
	$(chkDef "FALSE") "$CA_CISCOVPN" "$CD_CISCOVPN" \
	$(chkDef "FALSE") "$CA_CRYPTER" "$CD_CRYPTER" \
	$(chkDef "FALSE") "$CA_ENPASS" "$CD_ENPASS" \
	$(chkDef "FALSE") "$CA_GEM" "$CD_GEM" \
	$(chkDef "FALSE") "$CA_GNS" "$CD_GNS" \
	$(chkDef "FALSE") "$CA_GUFW" "$CD_GUFW" \
	$(chkDef "FALSE") "$CA_HACKINGPACK" "$CD_HACKINGPACK" \
	$(chkDef "FALSE") "$CA_KEEPASS" "$CD_KEEPASS" \
	$(chkDef "TRUE") "$CA_KEEPASSXC" "$CD_KEEPASSXC" \
	$(chkDef "FALSE") "$CA_MYSQLWB" "$CD_MYSQLWB" \
	$(chkDef "FALSE") "$CA_SIRIKALI" "$CD_SIRIKALI" \
	$(chkDef "FALSE") "$CA_UPM" "$CD_UPM" \
	$(chkDef "FALSE") "$CA_VERACRYPT" "$CD_VERACRYPT" \
	$(chkDef "FALSE") "$CA_WIRESHARK" "$CD_WIRESHARK" \
	FALSE "$SCT_GAMING" "===========================================================" \
	$(chkDef "FALSE") "$CA_0AD" "$CD_0AD" \
	$(chkDef "FALSE") "$CA_ALBION" "$CD_ALBION" \
	$(chkDef "FALSE") "$CA_ASSAULTCUBE" "$CD_ASSAULTCUBE" \
	$(chkDef "FALSE") "$CA_WESNOTH" "$CD_WESNOTH" \
	$(chkDef "FALSE") "$CA_DOFUS" "$CD_DOFUS" \
	$(chkDef "FALSE") "$CA_FLIGHTGEAR" "$CD_FLIGHTGEAR" \
	$(chkDef "FALSE") "$CA_FROZENBUBBLE" "$CD_FROZENBUBBLE" \
	$(chkDef "FALSE") "$CA_GNOMEGAMES" "$CD_GNOMEGAMES" \
	$(chkDef "FALSE") "$CA_KAPMAN" "$CD_KAPMAN" \
	$(chkDef "FALSE") "$CA_LOL" "$CD_LOL" \
	$(chkDef "FALSE") "$CA_LUTRIS" "$CD_LUTRIS" \
	$(chkDef "FALSE") "$CA_MEGAGLEST" "$CD_MEGAGLEST" \
	$(chkDef "FALSE") "$CA_MINECRAFT" "$CD_MINECRAFT" \
	$(chkDef "FALSE") "$CA_MINETEST" "$CD_MINETEST" \
	$(chkDef "FALSE") "$CA_OPENARENA" "$CD_OPENARENA" \
	$(chkDef "FALSE") "$CA_PINGUS" "$CD_PINGUS" \
	$(chkDef "FALSE") "$CA_POKERTH" "$CD_POKERTH" \
	$(chkDef "FALSE") "$CA_QUAKE" "$CD_QUAKE" \
	$(chkDef "FALSE") "$CA_REDECLIPSE" "$CD_REDECLIPSE" \
	$(chkDef "FALSE") "$CA_RUNESCAPE" "$CD_RUNESCAPE" \
	$(chkDef "FALSE") "$CA_STEAM" "$CD_STEAM" \
	$(chkDef "FALSE") "$CA_SUPERTUX" "$CD_SUPERTUX" \
	$(chkDef "FALSE") "$CA_SUPERTUXKART" "$CD_SUPERTUXKART" \
	$(chkDef "FALSE") "$CA_TAROT" "$CD_TAROT" \
	$(chkDef "FALSE") "$CA_TEEWORLDS" "$CD_TEEWORLDS" \
	$(chkDef "FALSE") "$CA_UT4" "$CD_UT4" \
	$(chkDef "FALSE") "$CA_XBOARD" "$CD_XBOARD" \
	$(chkDef "FALSE") "$CA_XQF" "$CD_XQF" \
	FALSE "$SCT_DEV" "===========================================================" \
	$(chkDef "FALSE") "$CA_ANDROIDSTUDIO" "$CD_ANDROIDSTUDIO" \
	$(chkDef "FALSE") "$CA_ANJUTA" "$CD_ANJUTA" \
	$(chkDef "FALSE") "$CA_ATOM" "$CD_ATOM" \
	$(chkDef "FALSE") "$CA_BLUEFISH" "$CD_BLUEFISH" \
	$(chkDef "FALSE") "$CA_BLUEGRIFFON" "$CD_BLUEGRIFFON" \
	$(chkDef "FALSE") "$CA_BRACKETS" "$CD_BRACKETS" \
	$(chkDef "FALSE") "$CA_CODEBLOCKS" "$CD_CODEBLOCKS" \
	$(chkDef "FALSE") "$CA_ECLIPSE" "$CD_ECLIPSE" \
	$(chkDef "FALSE") "$CA_EMACS" "$CD_EMACS" \
	$(chkDef "FALSE") "$CA_GEANY" "$CD_GEANY" \
	$(chkDef "FALSE") "$CA_INTELLIJIDEA" "$CD_INTELLIJIDEA" \
	$(chkDef "FALSE") "$CA_JEDIT" "$CD_JEDIT" \
	$(chkDef "FALSE") "$CA_PYCHARM" "$CD_PYCHARM" \
	$(chkDef "FALSE") "$CA_SCITE" "$CD_SCITE" \
	$(chkDef "FALSE") "$CA_SUBLIMETEXT" "$CD_SUBLIMETEXT" \
	$(chkDef "FALSE") "$CA_TEXSTUDIO" "$CD_TEXSTUDIO" \
	$(chkDef "FALSE") "$CA_TEXWORKS" "$CD_TEXWORKS" \
	$(chkDef "TRUE") "$CA_VIM" "$CD_VIM" \
	$(chkDef "FALSE") "$CA_VSCODE" "$CD_VSCODE" \
	FALSE "$SCT_OPTIMISATION" "===========================================================" \
	$(chkDef "FALSE") "$CA_IMPRIMANTE" "$CD_IMPRIMANTE" \
	$(chkDef "FALSE") "$CA_CONKY" "$CD_CONKY" \
	$(chkDef "FALSE") "$CA_GAMEMODE" "$CD_GAMEMODE" \
	$(chkDef "FALSE") "$CA_GS_AUGMENTATIONCAPTURE" "$CD_GS_AUGMENTATIONCAPTURE" \
	$(chkDef "FALSE") "$CA_GS_MINIMISATIONFENETRE" "$CD_GS_MINIMISATIONFENETRE" \
	$(chkDef "FALSE") "$CA_GRUBDEFAULT" "$CD_GRUBDEFAULT" \
	$(chkDef "FALSE") "$CA_GRUBATTENTE" "$CD_GRUBATTENTE" \
	$(chkDef "FALSE") "$CA_GTWEAKTOOL" "$CD_GTWEAKTOOL" \
	$(chkDef "FALSE") "$CA_DVDREAD" "$CD_DVDREAD" \
	$(chkDef "FALSE") "$CA_PACKICON" "$CD_PACKICON" \
	$(chkDef "FALSE") "$CA_PACKTHEME" "$CD_PACKTHEME" \
	$(chkDef "FALSE") "$CA_INTEL" "$CD_INTEL" \
	$(chkDef "FALSE") "$CA_NVNOUVEAU" "$CD_NVNOUVEAU" \
	$(chkDef "FALSE") "$CA_NVIDIA" "$CD_NVIDIA" \
	$(chkDef "FALSE") "$CA_NAUTILUS_EXTRA" "$CD_NAUTILUS_EXTRA" \
	$(chkDef "FALSE") "$CA_SYSFIC" "$CD_SYSFIC" \
	$(chkDef "FALSE") "$CA_TLP" "$CD_TLP" \
	$(chkDef "FALSE") "$CA_ZRAM" "$CD_ZRAM" \
	FALSE "$SCT_END" "===========================================================" \
	$(chkDef "TRUE") "$CA_AUTOREMOVE" "$CD_AUTOREMOVE" \
	--separator='| ');

if [ $? = 0 ]
then
    # Debut
	f_action_exec "$CA_UPGRADE" "sudo pacman -Syyu --noconfirm" "$NS_UPGRADE"
	f_action_install "$CA_FLATPAK" flatpak
	f_action_exec "$CA_FLATPAK" "sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"
    
    # Navigateurs
    f_action_aur_install "$CA_BEAKER" beaker-browser-bin
    f_action_aur_install "$CA_BRAVE" brave-bin
    f_action_install "$CA_CHROMIUM" chromium
    f_action_install "$CA_DILLO" dillo
    f_action_install "$CA_EOLIE" eolie
    f_action_install "$CA_FALKON" falkon
   	f_action_install "$CA_FIREFOX" "firefox firefox-i18n-fr"
   	f_action_aur_install "$CA_FIREFOXBETA" firefox-beta-bin
   	f_action_install "$CA_FIREFOXDEV" "firefox-developer-edition firefox-developer-edition-i18n-fr"
   	f_action_aur_install "$CA_FIREFOXESR" firefox-esr-bin
   	f_action_aur_install "$CA_FIREFOXNIGHTLY" firefox-nightly
    f_action_install "$CA_EPIPHANY" epiphany
	f_action_aur_install "$CA_CHROME" google-chrome
    f_action_install "$CA_LYNX" lynx
   	f_action_install "$CA_MIDORI" midori
    f_action_install "$CA_MIN" min
    f_action_install "$CA_OPERA" opera
    f_action_aur_install "$CA_TORBROWSER" tor-browser
    f_action_aur_install "$CA_VIVALDI" vivaldi

    # Internet / Transfert / Tchat
    f_action_install "$CA_AMULE" amule
    f_action_install "$CA_CLUSTERSSH" clusterssh
    f_action_install "$CA_DELUGE" deluge
	f_action_aur_install "$CA_DISCORD" discord
	f_action_aur_install "$CA_DUKTO" dukto
    f_action_install "$CA_EMPATHY" empathy    
	f_action_install "$CA_FILEZILLA" filezilla    
	f_action_aur_install "$CA_FROSTWIRE" frostwire
	f_action_install "$CA_HEXCHAT" hexchat  
	f_action_install "$CA_HUBIC" hubicfuse
	f_action_install "$CA_MUMBLE" mumble 
	f_action_install "$CA_NICOTINE" nicotine+
	f_action_install "$CA_PIDGIN" "pidgin pidgin-libnotify"
	f_action_install "$CA_POLARI" polari
	f_action_install "$CA_PSI" psi
	f_action_aur_install "$CA_QARTE" qarte
	f_action_install "$CA_QBITTORRENT" qbittorrent
	f_action_install "$CA_RDESKTOP" rdesktop
	f_action_install "$CA_RING" ring-gnome #Nouveau nom : Jami
	f_action_install "$CA_RIOT" riot-desktop
	f_action_aur_install "$CA_SIGNAL" signal-desktop-bin
    f_action_aur_install "$CA_SKYPE" skypeforlinux-stable-bin
	f_action_aur_install "$CA_SLACK" slack-desktop
    f_action_install "$CA_SUBDOWNLOADER" subdownloader
	f_action_install "$CA_TEAMSPEAK" teamspeak3
	f_action_install "$CA_TELEGRAM" telegram-desktop
	f_action_install "$CA_UGET" uget	
	f_action_aur_install "$CA_VUZE" vuze
	f_action_install "$CA_WEECHAT" weechat
	f_action_aur_install "$CA_WHALEBIRD" whalebird-bin
    f_action_aur_install "$CA_WHATSAPP" whatsapp-nativefier
    f_action_aur_install "$CA_WIRE" wire-desktop-bin

	# Lecture Multimedia
	f_action_install "$CA_AUDACIOUS" audacious
	f_action_aur_install "$CA_BANSHEE" banshee
	f_action_install "$CA_CANTATA" cantata
	f_action_install "$CA_CLEMENTINE" clementine
	f_action_get_appimage "$CA_DEEZLOADER" "https://srv-file5.gofile.io/download/r4sZke/Deezloader_Remix_4.3.0-x86_64.AppImage"
	f_action_install "$CA_FLASH" "flashplugin pepper-flash"
	f_action_aur_install "$CA_GMUSICBROWSER" gmusicbrowser
    f_action_install "$CA_GNOMEMPV" celluloid
    f_action_install "$CA_GNOMEMUSIC" gnome-music
    f_action_install "$CA_GNOMETWITCH" gnome-twitch
	f_action_aur_install "$CA_GRADIO" gradio
	f_action_install "$CA_LOLLYPOP" lollypop
	f_action_aur_install "$CA_MOLOTOVTV" molotov
    f_action_install "$CA_PAVUCONTROL" pavucontrol	
    f_action_install "$CA_QMMP" qmmp	
    f_action_install "$CA_QUODLIBET" quodlibet	
    f_action_install "$CA_RHYTHMBOX" rhythmbox		
    f_action_install "$CA_SHOTWELL" shotwell	
    f_action_install "$CA_SMPLAYER" "smplayer smplayer-themes"	    
    f_action_aur_install "$CA_SPOTIFY" spotify
	f_action_install "$CA_VLCSTABLE" vlc
	f_action_aur_install "$CA_VLCDEV" vlc-git
		
	# Montage Multimédia
	f_action_install "$CA_ARDOUR" ardour
	f_action_install "$CA_AUDACITY" audacity
	f_action_install "$CA_AVIDEMUX" "avidemux-qt avidemux-cli"
	f_action_install "$CA_BLENDER" blender	
	f_action_aur_install "$CA_CINELERRA" cinelerra-cv
	f_action_install "$CA_DARKTABLE" darktable
	f_action_install "$CA_EASYTAG" easytag
	f_action_aur_install "$CA_FLACON" flacon
	f_action_install "$CA_FLAMESHOT" flameshot
	f_action_aur_install "$CA_FLOWBLADE" flowblade-git
	f_action_flatpak_install "$CA_FREECAD" org.freecadweb.FreeCAD
	f_action_install "$CA_GIADA" giada
	f_action_install "$CA_GIMP" "gimp gimp-help-fr"	
	f_action_install "$CA_GNOMESOUNDRECORDER" gnome-sound-recorder
	f_action_install "$CA_HANDBRAKE" handbrake
	f_action_install "$CA_HYDROGEN" hydrogen
	f_action_flatpak_install "$CA_IMCOMPRESSOR" com.github.huluti.ImCompressor
	f_action_install "$CA_INKSCAPE" inkscape
	f_action_aur_install "$CA_KAZAM" kazam	
	f_action_install "$CA_KDENLIVE" kdenlive		
	f_action_install "$CA_KOLOURPAINT" kolourpaint	
	f_action_install "$CA_KRITA" krita
	f_action_aur_install "$CA_LEOCAD" leocad
	f_action_aur_install "$CA_LIGHTWORKS" lwks
	f_action_install "$CA_LIBRECAD" librecad
	f_action_aur_install "$CA_LIVES" lives	
	f_action_install "$CA_LUMINANCE" luminancehdr
	f_action_install "$CA_LMMS" lmms	
	f_action_aur_install "$CA_MHWAVEEDIT" mhwaveedit	
	f_action_install "$CA_MIXXX" mixxx
	f_action_install "$CA_MUSESCORE" musescore	
	f_action_install "$CA_MYPAINT" mypaint 
	f_action_flatpak_install "$CA_NATRON" fr.natron.Natron
	f_action_install "$CA_OBS" "ffmpeg obs-studio"
	f_action_aur_install "$CA_OLIVE" olive
	f_action_install "$CA_OPENSHOT" openshot
	f_action_aur_install "$CA_OPENTOONZ" opentoonz
	f_action_install "$CA_PEEK" peek
	f_action_install "$CA_PINTA" pinta	
	f_action_install "$CA_PITIVI" pitivi	
	f_action_aur_install "$CA_PIXELUVO" pixeluvo
	f_action_install "$CA_RAWTHERAPEE" rawtherapee
	f_action_install "$CA_ROSEGARDEN" rosegarden
	f_action_install "$CA_SHOTCUT" shotcut
	f_action_aur_install "$CA_SHUTTER" shutter
	f_action_install "$CA_SIMPLESCREENRECORDER" simplescreenrecorder
	f_action_install "$CA_SOUNDJUICER" sound-juicer
	f_action_install "$CA_SWEETHOME" sweethome3d
	f_action_aur_install "$CA_SYNFIG" synfigstudio
	f_action_aur_install "$CA_UNITY3DEDITOR" unity-editor
	f_action_flatpak_install "$CA_VIDCUTTER" "com.ozmartians.VidCutter"
	f_action_aur_install "$CA_VOKOSCREEN" vokoscreen
	f_action_aur_install "$CA_WINFF" qwinff
	f_action_aur_install "$CA_XNVIEW" xnviewmp
	
	# Bureautique/Mail
	f_action_aur_install "$CA_BOOSTNOTE" boostnote
	f_action_install "$CA_CALLIGRA" calligra
	f_action_install "$CA_FRDIC" "aspell-fr hyphen-fr mythes-fr"
	f_action_install "$CA_FBREADER" fbreader
	f_action_install "$CA_FEEDREADER" feedreader
	f_action_aur_install "$CA_FREEOFFICE" freeoffice
	f_action_aur_install "$CA_FREEPLANE" freeplane
	f_action_install "$CA_GEARY" geary	
	f_action_install "$CA_EVOLUTION" evolution
	f_action_install "$CA_GNOMEOFFICE" "abiword gnumeric dia planner glabels glom tomboy gnucash"	
	f_action_install "$CA_GRAMPS" gramps
	f_action_install "$CA_LIBREOFFICEFRESH" "libreoffice-fresh libreoffice-fresh-fr"
	f_action_install "$CA_LIBREOFFICESTILL" "libreoffice-still libreoffice-still-fr"
	f_action_aur_install "$CA_MAILSPRING" mailspring
	f_action_aur_install "$CA_MASTERPDFEDITOR" masterpdfeditor-free
	f_action_aur_install "$CA_NOTESUP" notes-up  
	f_action_aur_install "$CA_ONLYOFFICE" onlyoffice-bin
    f_action_aur_install "$CA_OPENOFFICE" openoffice
    f_action_install "$CA_PDFMOD" pdfmod
    f_action_install "$CA_PDFSAM" pdfsam
    f_action_aur_install "$CA_POLICEMST" ttf-ms-fonts
    f_action_install "$CA_SCRIBUS" scribus	
 	f_action_install "$CA_THUNDERBIRD" "thunderbird thunderbird-i18n-fr"
	f_action_aur_install "$CA_WPSOFFICE" wps-office
	f_action_aur_install "$CA_XMIND" xmind-zen
	f_action_install "$CA_XPAD" xpad
	f_action_install "$CA_ZIM" zim
	
	# Science/Education
	f_action_aur_install "$CA_ALGOBOX" algobox
	f_action_aur_install "$CA_AVOGADRO" avogadro2-git
	f_action_install "$CA_CELESTIA" celestia
	f_action_aur_install "$CA_CONVERTALL" convertall
	f_action_aur_install "$CA_GANTTPROJECT" ganttproject
	f_action_flatpak_install "$CA_GCOMPRIS" org.kde.gcompris
	f_action_aur_install "$CA_GELEMENTAL" gelemental
	f_action_install "$CA_GEOGEBRA" geogebra
	f_action_install "$CA_GNOMEMAPS" gnome-maps
	f_action_aur_install "$CA_GOOGLEEARTH" google-earth-pro
	f_action_aur_install "$CA_GPREDICT" gpredict
	f_action_install "$CA_JOSM" josm
	f_action_install "$CA_KICAD" "kicad kicad-library kicad-library-3d"
	f_action_install "$CA_MARBLE" marble
	f_action_aur_install "$CA_MBLOCK" mblock
	f_action_flatpak_install "$CA_OPENBOARD" ch.openboard.OpenBoard
	f_action_install "$CA_PLANNER" planner
	f_action_aur_install "$CA_SCILAB" scilab
	f_action_install "$CA_STELLARIUM" stellarium
	f_action_install "$CA_XCAS" xcas
	
	# Utilitaires graphiques
	f_action_aur_install "$CA_ANYDESK" anydesk
	f_action_install "$CA_BRASERO" brasero
	f_action_install "$CA_CHEESE" cheese
	f_action_install "$CA_DEJADUP" deja-dup
	f_action_aur_install "$CA_DIODON" diodon-git
    f_action_install "$CA_DOSBOX" dosbox
    f_action_install "$CA_ELECTRUM" electrum
    f_action_install "$CA_ETHEREUMWALLET" etherwall
    f_action_install "$CA_GNOMEBOXES" gnome-boxes
	f_action_install "$CA_GNOME_DISK" gnome-disk-utility
	f_action_install "$CA_GNOMERECIPES" gnome-recipes
	f_action_install "$CA_GSYSLOG" gnome-system-log
	f_action_install "$CA_GSYSMON" gnome-system-monitor
	f_action_install "$CA_GPARTED" gparted
	f_action_aur_install "$CA_JRE8" jre8
	f_action_aur_install "$CA_JRE11" jre
    f_action_install "$CA_MELD" meld
	f_action_aur_install "$CA_MULTISYSTEM" multisystem
	f_action_aur_install "$CA_ARCHIVAGE" "unace rar unrar-free p7zip sharutils uudeview mpack arj cabextract lzip lunzip"
	f_action_install "$CA_POL" playonlinux
	f_action_install "$CA_PUTTY" putty
	f_action_install "$CA_QEMUKVM" "qemu virt-manager virt-viewer"
	f_action_install "$CA_REDSHIFT" redshift
	f_action_install "$CA_SPEEDCRUNCH" speedcrunch
	f_action_install "$CA_REMMINA" remmina
	f_action_aur_install "$CA_SUBLIM_NAUT" subliminal
	f_action_install "$CA_SUB_EDIT" subtitleeditor
	f_action_aur_install "$CA_TEAMVIEWER" teamviewer
	f_action_install "$CA_TERMINATOR" terminator
	f_action_install "$CA_TILIX" tilix
	f_action_aur_install "$CA_TIMESHIFT" timeshift
	f_action_install "$CA_VARIETY" variety
	f_action_install "$CA_VBOXDEPOT" virtualbox
	f_action_aur_install "$CA_VMWARE" vmware-workstation
	f_action_install "$CA_WINE" "wine winetricks"
	f_action_install "$CA_X2GO" x2goclient
	f_action_install "$CA_X11VNC" x11vnc
	
	# Utilitaires en CLI
	f_action_install "$CA_DDRESCUE" ddrescue
	f_action_install "$CA_FD" fd
	f_action_install "$CA_HTOP" htop
	f_action_install "$CA_GLANCES" glances
	f_action_install "$CA_LAME" lame
	f_action_install "$CA_HG" mercurial
	f_action_install "$CA_PACKOUTILS" "neofetch asciinema ncdu screen"
	f_action_aur_install "$CA_POWERSHELL" powershell-bin
	f_action_install "$CA_RIPGREP" ripgrep #utilise la commande "rg"
	f_action_install "$CA_RTORRENT" rtorrent
	f_action_install "$CA_SMARTMONTOOLS" smartmontools
	f_action_install "$CA_SPEEDTEST" speedtest-cli
	f_action_install "$CA_TESTDISK" testdisk
	f_action_aur_install "$CA_TLDR" tealdeer ## vérifier si c'est bien TLDR
	f_action_aur_install "$CA_WORDGRINDER" wordgrinder
	f_action_install "$CA_YTDLND" youtube-dl

	# Réseaux et sécurité
	f_action_install "$CA_ANSIBLE" ansible
	f_action_aur_install "$CA_BITWARDEN" bitwarden-bin
	f_action_install "$CA_CISCOVPN" "openconnect networkmanager-openconnect"
	f_action_get_appimage "$CA_CRYPTER" "https://github.com/HR/Crypter/releases/download/v3.1.0/Crypter-3.1.0-x86_64.AppImage"
	f_action_aur_install "$CA_ENPASS" enpass-bin
	f_action_aur_install "$CA_GEM" gnome-encfs-manager-bin
	f_action_aur_install "$CA_GNS" gns3-gui
	f_action_install "$CA_GUFW" gufw
	f_action_install "$CA_HACKINGPACK" "tcpdump nmap aircrack-ng ophcrack john hashcat wifite"
	f_action_aur_install "$CA_HACKINGPACK" "netdiscover crunch"
	f_action_install "$CA_KEEPASS" keepass
    f_action_install "$CA_KEEPASSXC" keepassxc
	f_action_install "$CA_MYSQLWB" mysql-workbench
	f_action_aur_install "$CA_SIRIKALI" sirikali
	f_action_aur_install "$CA_UPM" upm
	f_action_install "$CA_VERACRYPT" veracrypt
	f_action_install "$CA_WIRESHARK" "wireshark-qt wireshark-cli"
	
	# Gaming
	f_action_install "$CA_0AD" 0ad
	f_action_flatpak_install "$CA_ALBION" com.albiononline.AlbionOnline
	f_action_install "$CA_ASSAULTCUBE" assaultcube
	f_action_install "$CA_WESNOTH" wesnoth
	f_action_aur_install "$CA_DOFUS" dofus
	f_action_aur_install "$CA_FLIGHTGEAR" flightgear
	f_action_install "$CA_FROZENBUBBLE" frozen-bubble
	f_action_install "$CA_GNOMEGAMES" "gnome-games gnome-2048 gnome-chess gnome-mines gnome-robots gnome-sudoku gnome-taquin"
	f_action_install "$CA_KAPMAN" kapman
	f_action_aur_install "$CA_LOL" leagueoflegends-git
	f_action_exec "$CA_LOL" "leagueoflegends install"
	f_action_install "$CA_LUTRIS" lutris
	f_action_install "$CA_MEGAGLEST" megaglest
	f_action_aur_install "$CA_MINECRAFT" minecraft-launcher
	f_action_install "$CA_MINETEST" minetest
	f_action_aur_install "$CA_OPENARENA" openarena
	f_action_install "$CA_PINGUS" pingus
	f_action_aur_install "$CA_POKERTH" pokerth
	f_action_aur_install "$CA_QUAKE" vkquake2-git
	f_action_flatpak_install "$CA_REDECLIPSE" net.redeclipse.RedEclipse
	f_action_aur_install "$CA_RUNESCAPE" runescape-launcher
	f_action_install "$CA_STEAM" steam
	f_action_install "$CA_SUPERTUX" supertux
	f_action_install "$CA_SUPERTUXKART" supertuxkart	
	f_action_flatpak_install "$CA_TAROT" eu.planete_kraus.Tarot
	f_action_install "$CA_TEEWORLDS" teeworlds
	f_action_exec "$CA_UT4" "wget https://gitlab.com/simbd/Scripts_divers/raw/master/UnrealTournament4_Install.sh ; chmod +x UnrealTournament*"
	f_action_install "$CA_XBOARD" "xboard gnuchess"
	f_action_aur_install "$CA_XQF" xqf
	
	# Programmation / Dev  
	f_action_aur_install "$CA_ANDROIDSTUDIO" android-studio
	f_action_install "$CA_ANJUTA" "anjuta anjuta-extras"
	f_action_install "$CA_ATOM" atom
	f_action_install "$CA_BLUEFISH" bluefish
	f_action_install "$CA_BLUEGRIFFON" bluegriffon
	f_action_aur_install "$CA_BRACKETS" brackets-bin
	f_action_install "$CA_CODEBLOCKS" codeblocks
	f_action_install "$CA_ECLIPSE" eclipse-java
	f_action_install "$CA_EMACS" emacs
	f_action_install "$CA_GEANY" "geany geany-plugins"	
	f_action_install "$CA_INTELLIJIDEA" intellij-idea-community-edition
	f_action_install "$CA_JEDIT" jedit
	f_action_install "$CA_PYCHARM" pycharm-community-edition
	f_action_aur_install "$CA_SCITE" scite
	f_action_aur_install "$CA_SUBLIMETEXT" sublime-text-3-imfix
	f_action_install "$CA_TEXSTUDIO" texstudio
	f_action_aur_install "$CA_TEXWORKS" texworks
	f_action_install "$CA_VIM" vim
	f_action_install "$CA_VSCODE" code
	
	# Hardware, Customisation et Optimisation
	f_action_install "$CA_IMPRIMANTE" "hplip sane"
	f_action_install "$CA_CONKY" conky
	f_action_exec "$CA_CONKY" "wget https://gitlab.com/simbd/Fichier_de_config/raw/master/.conkyrc ; mv .conkyrc ~/"
    f_action_aur_install "$CA_GAMEMODE" gamemode
	f_action_exec "$CA_GS_AUGMENTATIONCAPTURE" "gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 600"
	f_action_exec "$CA_GS_MINIMISATIONFENETRE" "gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'"
	f_action_exec "$CA_GRUBDEFAULT" "sudo sed -ri 's/GRUB_DEFAULT=0/GRUB_DEFAULT="saved"/g' /etc/default/grub ; echo 'GRUB_SAVEDEFAULT="true"' | sudo tee -a /etc/default/grub ; sudo grub-mkconfig -o /boot/grub/grub.cfg"
	f_action_exec "$CA_GRUBATTENTE" "sudo sed -ri 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/g' /etc/default/grub ; sudo mkdir /boot/old ; sudo mv /boot/memtest86* /boot/old/ ; sudo grub-mkconfig -o /boot/grub/grub.cfg"
	f_action_install "$CA_GTWEAKTOOL" gnome-tweaks
	f_action_install "$CA_DVDREAD" "libdvdcss libdvdread"
	f_action_aur_install "$CA_PACKICON" "papirus-icon-theme numix-icon-theme-git breeze-icons elementary-icon-theme oxygen-icons"  ## icon gnome-brave en moins
	f_action_aur_install "$CA_PACKTHEME" "arc-gtk-theme numix-gtk-theme materia-gtk-theme yuyo-gtk-theme-git"
	f_action_install "$CA_INTEL" intel-ucode
	f_action_aur_install "$CA_NVNOUVEAU" switcheroo-control
	f_action_install "$CA_NVIDIA" "nvidia nvidia-settings"
	f_action_aur_install "$CA_NAUTILUS_EXTRA" "nautilus-open-terminal-git nautilus-compare"
	f_action_install "$CA_SYSFIC" "btrfs-progs exfat-utils xfsprogs"
	f_action_install "$CA_TLP" "tlp tlp-rdw"
	f_action_aur_install "$CA_ZRAM" zramswap
    
    # Fin
	f_action_exec "$CA_AUTOREMOVE" "sudo pacman -Syu --noconfirm ; sudo pacman -Sc --noconfirm"

	# Notification End 
	notify-send -i dialog-ok "$NS_END_TITLE" "$NS_END_TEXT" -t 5000

	zenity --warning --no-wrap --height 500 --width 900 --title "$MSG_END_TITLE" --text "$MSG_END_TEXT"
else
	zenity --question --title "$MSG_END_CANCEL_TITLE" --text "$MSG_END_CANCEL_TEXT"
	if [ $? == 0 ] 
	then
		gxmessage -center -geometry 400x900 -name "$MSG_END_TITLE" "$MSG_END_TEXT"
	fi
fi
