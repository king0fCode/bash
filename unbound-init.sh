#!/bin/sh

#First STEP

# --------------------------------------------------------------------
# Instructions 

# root@local:~~: cd ~
# root@local:~~: nano unbound-init.sh
# (paste the attached code there and Save using ctrl + O and Exit using Ctrl + X.)

# root@local:~~: cp /etc/rc.local /etc/rc.local.backup   
# (backing up the default backup)
# root@local:~~: sudo chmod +x /etc/rc.d/rc.local
# And then
# --------------------------------------------------------------------

# 2 SECOND STEP 


# Method 1
# root@local:~~: echo "/bin/sh /unbound-init.sh restart" >> /etc/rc.local
# (adding command to end of /etc/rc.local)
# Once all done. Make sure to restart and check.
# Note: Please make sure you type the commands spelling correctly

#Method 2

# -----------------------------------------------------------------
# root@local:~~: crontab –e
##Add your script here….
# @reboot /unbound-init.sh

# Save and Exit

#method 3 
# Method 3:  Executing Linux Scripts at Logout and Login
# This method is used to execute the script at ssh-user Login or Logout, Just you need to add 
# root@local:~~:echo "/bin/sh /unbound-init.sh restart" >> ~/.bash_profile



#Notes: 
#  root@local:~~: ./unbound-init.sh restart (Command Which Initiate unbound Reboot)

PATH=/sbin:/bin:/usr/sbin:/usr/bin

. /lib/lsb/init-functions

DAEMON=/usr/local/sbin/unbound
PIDFILE=/usr/local/etc/unbound/unbound.pid

test -x $DAEMON || exit 5

if [ -r /etc/default/unbound ]; then
	. /etc/default/unbound
fi

LOCKFILE=/var/lock/unbound

lock_unbound() {
	if [ -x /usr/bin/lockfile-create ]; then
		lockfile-create $LOCKFILE
		lockfile-touch $LOCKFILE &
		LOCKTOUCHPID="$!"
	fi
}

unlock_unbound() {
	if [ -x /usr/bin/lockfile-create ] ; then
		kill $LOCKTOUCHPID
		lockfile-remove $LOCKFILE
	fi
}

case $1 in
	start)
		log_daemon_msg "Starting unbound server" "unbound"
		lock_unbound
  		start-stop-daemon --start --quiet --oknodo --pidfile $PIDFILE --startas $DAEMON -- $UNBOUND_OPTS
		status=$?
		unlock_unbound
		log_end_msg $status
  		;;
	stop)
		log_daemon_msg "Stopping unbound server" "unbound"
  		start-stop-daemon --stop --quiet --oknodo --pidfile $PIDFILE
		log_end_msg $?
		rm -f $PIDFILE
  		;;
	restart|force-reload)
		$0 stop && sleep 2 && $0 start
  		;;
	try-restart)
		if $0 status >/dev/null; then
			$0 restart
		else
			exit 0
		fi
		;;
	reload)
		exit 3
		;;
        config-test)
                if [ -f /usr/local/etc/unbound/unbound.conf ] ; then
                        message=$(/usr/local/sbin/unbound-checkconf)
                        log_end_msg $? $mesasge
		else
			echo "No config file found" >&2
			log_end_msg 2
                fi
                ;;
	status)
		status_of_proc $DAEMON "unbound server"
		;;
	*)
		echo "Usage: $0 {start|stop|restart|try-restart|force-reload|status|config-test}"
		exit 2
		;;
esac






### BEGIN INIT INFO
# Provides:        unbound
# Required-Start:  $network $remote_fs $syslog
# Required-Stop:   $network $remote_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop: 
# Short-Description: Start unbound daemon
### END INIT INFO