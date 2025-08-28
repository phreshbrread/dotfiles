# Environment vars
export GDK_SCALE=1
export XCURSOR_SIZE=48

# Statusbar loop
while true; do
   ~/dotfiles/dwm-statusbar.sh
done &

# Start DWM
exec dwm
