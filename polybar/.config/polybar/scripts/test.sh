rofi=$(pgrep -x rofi >/dev/null && echo "Process found" || echo "Process not found")
On_Cyan='\033[46m'        # Cyan
On_Blue='\033[44m'        # Blue

if [[ $rofi == "Process found" ]]; then
	echo 'van'
else
	echo -e "${On_Blue}loc"
fi

