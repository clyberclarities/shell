#!/bin/bash
display_result() {
  dialog --title "$1" \
    --backtitle "System Information" \
    --no-collapse \
    --msgbox "$result" 0 0
}

while true; do
  selection=$(dialog --stdout \
    --backtitle "Ansible System Information" \
    --title "System Tools" \
    --clear \
    --cancel-label "Exit" \
    --menu "Please select:" 0 0 7 \
    "1" "Display Node Information" \
    "2" "Display Disk Space" \
    "3" "Display Memory Stats" \
    "4" "Ping All Nodes" \
    "5" "Update RPM Based Systems _ POSSIBLE REBOOT" \
    "6" "List DEB updates" \
    "7" "Update DEB Based Systems - POSSIBLE REBOOT" \
    )

  exit_status=$?
  if [ $exit_status == 1 ] ; then
      clear
      exit
  fi
  case $selection in
    1 )
      result=$(echo "Hostname: $HOSTNAME"; uptime; /home/legion/scripts/cputemp.sh)
      display_result "System Information"
      ;;
    2 )
      result=$(df -h)
      display_result "Disk Space"
      ;;
    3 )
      result=$(vmstat --stats --unit M)
      display_result "Memory Stats"
      ;;
    4 )
      result=$(ansible-playbook /opt/playbooks/ping_all.yml)
      display_result "Ping Ansible Managed Hosts"
      ;;
    5 )
      result=$(ansible-playbook /opt/playbooks/upd_rpm.yml)
      display_result "Update RPM Based Systems"
      ;;
    6 )
      result=$(ansible-playbook /opt/playbooks/lst_deb.yml)
      display_result "Listing DEB Updates"
      ;;
    7 )
      result=$(ansible-playbook /opt/playbooks/update_deb.yml)
      display_result "Update DEB Based Systems"
      ;;

  esac
done