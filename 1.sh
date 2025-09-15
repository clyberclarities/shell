#!/bin/bash

# Define functions
print_date() {
    echo "Current date: $(date)"
}

list_users() {
    echo "Listing all users:"
    cut -d: -f1 /etc/passwd
}

restart_network() {
    echo "Restarting the network..."
    sudo systemctl restart networking.service
    echo "Network restarted successfully."
}

show_help() {
    echo "Menu Options:"
    echo "1: Print current date"
    echo "2: List all users"
    echo "3: Restart network service"
    echo "4: Show this help message"
    echo "0: Exit the menu"
}

# Main menu loop
while true; do
    clear
    echo "Main Menu:"
    show_help
    read -p "Choose an option [1-4]: " option

    case $option in
        1) print_date ;;
        2) list_users ;;
        3) restart_network ;;
        4) show_help ;;
        0) echo "Exiting..."; exit 0;;
        *) echo "Invalid option. Please select a number between 1 and 4." && sleep