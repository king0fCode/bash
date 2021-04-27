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
