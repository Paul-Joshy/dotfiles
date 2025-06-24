#!/bin/bash

get_wifi() {
    iface=$(nmcli -t -f DEVICE,TYPE,STATE device | grep ':wifi:connected' | cut -d: -f1)
    if [ -n "$iface" ]; then
        ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
        echo " $ssid"
    else
        echo "睊 Disconnected"
    fi
}

get_battery() {
    if command -v acpi &> /dev/null; then
        status=$(acpi -b | awk -F': |, ' '{print $2}')
        percent=$(acpi -b | awk -F': |, ' '{print $3}')
        timeleft=$(acpi -b | awk -F': |, ' '{print $4}')
        case $status in
            Charging) echo " $percent (in $timeleft)" ;;
            Discharging) echo " $percent ($timeleft left)" ;;
            Full) echo " Full" ;;
            *) echo "$status $percent" ;;
        esac
    else
        echo "Battery: N/A"
    fi
}

get_time() {
    date '+ %a %d %b %I:%M%P'
}

get_volume() {
  if pamixer --get-mute | grep -q true; then
    echo "🔇"
  else
    vol=$(pamixer --get-volume)
    if [ "$vol" -lt 30 ]; then
      echo "🔈 $vol%"
    elif [ "$vol" -lt 70 ]; then
      echo "🔉 $vol%"
    else
      echo "🔊 $vol%"
    fi
  fi
}
while true; do
  xsetroot -name "$(get_wifi) | $(get_battery) | $(get_volume) | $(get_time)"

    sleep 0
done



