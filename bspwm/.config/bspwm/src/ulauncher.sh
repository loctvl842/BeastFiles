ulauncher=$(pgrep -x ulauncher > /dev/null && echo "Process found" || echo "Process not found")
echo $ulauncher
if [[ $ulauncher == "Process not found" ]]; then
  echo $ulauncher
  ulauncher &
else
  ulauncher-toggle
fi
