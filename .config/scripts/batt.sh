#!/bin/bash

# Function to get the remaining battery time
get_remaining_battery_time() {
    # Get the battery information using upower
    battery_info=$(upower -i $(upower -e | grep --color=never 'BAT'))
    
    # Extract the state, percentage, and time to empty/full
    state=$(echo "$battery_info" | grep "state" | awk '{print $2}')
    percentage=$(echo "$battery_info" | grep "percentage" | awk '{print $2}')
    time_to_empty=$(echo "$battery_info" | grep "time to empty" | awk '{print $4, $5}')
    time_to_full=$(echo "$battery_info" | grep "time to full" | awk '{print $4, $5}')
    plugged=$(cat /sys/class/power_supply/ACAD/online)

    # Display the results
    # echo "Battery Status: $state"
    # echo "Battery Percentage: $percentage"
    if [ "$state" == "discharging" ]; then
        time="(empty in $time_to_empty)"
    elif [ "$state" == "charging" ]; then
        time="(full in $time_to_full)"
    else
        time="neither"
    fi
    

    
    if [[ "$plugged" == "1" ]]; then
        state="🔌"
        echo "$state $percentage $time_to_full"
    else
        state="🔋"
        echo "$state $percentage $time_to_empty"
    fi
    
    if [[ $(echo "$time_to_empty" | grep -c 'minutes') == "1" ]]; then
        notify-send -u critical "🔌🔌🔌Charge Battery Now🔌🔌🔌"
    fi

}

# Call the function to display the battery time
get_remaining_battery_time
