#!/bin/bash

# Note: All API calls will trigger a system reboot if they suffer an exception

BASH=$(which bash)

LOGFILE=/opt/mining/var/log/cgminer-monitor.log

DIR=$(dirname $(readlink -f $0))
CALLDIR="$DIR/.."

MINER_BIN="vertminer.bufius"

SECONDS="120"

. $CALLDIR/lib/functions.sh

# Reboot the system. Make sure that the user under
# which the miner is running has NOPASSWD sudo permissions
# for /sbin/shutdown. See README.md for instructions.
function sys_reboot()
{
	sudo /sbin/shutdown -r now
}

# Kill the miner with great vengeance and furious anger
function miner_kill()
{
	killall -9 $MINER_BIN
	sleep 5
}

# Make a call to the API
function call_api()
{
	$BASH $CALLDIR/call.sh $1
}

# Return the number of seconds since the last share
function time_since_last_share()
{
    echo "$(date +%s)-$(call_api pools | grep 'Last Share Time' | awk '{print $NF}' | tr -d ',')" | bc
}

# Boolean whether we've made a share in the last $SECONDS
function sharing()
{
	return [ time_since_last_share -lt $SECONDS ]
}

# MAIN PROGRAM
echo "Starting check at $(date)" | tee -a $LOGFILE

# If we've gone longer than $SECONDS seconds since the
# last share
if [ ! sharing ]; then
	# Try restarting via an API call
	call_api restart

	# First give the soft-restart some time to take effect
	sleep 60

	# If still over 60 seconds since the last share
	if [ ! sharing ]; then
		# Try to kill the miner
		miner_kill

		# If we've had to kill it, check it's not defunct
		if [ ! -z "$(ps aux | grep [v]ertminer | grep defunct)" ]; then
			echo "Rebooting system due to defunct miner at $(date)" >&2 | tee -a $LOGFILE
			sys_reboot
		else
			echo "All OK after miner killed." | tee -a $LOGFILE
		fi
	fi

	sleep 60

	# If it's still more than 60 seconds since the last share time
	# for a full system reboot
	if [ ! sharing ]; then
		echo "Rebooting system due to miner still not working after API restart and proc kill at $(date)." | tee -a $LOGFILE
		sys_reboot
	else
		echo "All OK after miner killed. Checked at $(date)" | tee -a $LOGFILE
	fi
else
	echo "All OK at $(date). Current time since last share: $(time_since_last_share)s" | tee -a $LOGFILE
fi

