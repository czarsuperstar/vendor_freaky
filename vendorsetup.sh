lunch_others_targets=()
for device in $(curl -s https://raw.githubusercontent.com/FreakyOS/vendor_freaky/still_alive/freaky.devices)
do
    for var in user userdebug eng; do
        lunch_others_targets+=("freaky_$device-$var")
    done
done
