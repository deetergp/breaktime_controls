### Controls ###
# Begin your break: bt break
# End your break: bt work
# Begin BreakTime: bt start or bt enable
# Quit BreakTime: bt end or bt disable or bt quit
# Reset countdown to break: bt reset or bt punt

on sendMsg(msg)
  tell application "System Events"
    set isRunning to (count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp")) > 0
  end tell

  if isRunning then
    tell application id "com.Growl.GrowlHelperApp"
      set the allNotificationsList to {"BreakTime Notification"}
      set the enabledNotificationsList to {"BreakTime Notification"}
      register as application "BreakTime Controls" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "BreakTime"
      notify with name "BreakTime Notification" title "BreakTime" description msg application name "BreakTime Controls" icon of application "BreakTime"
    end tell
  end if
end sendMsg

on alfred_script(q)

  set msg to ""
  set s to {"start", "enable", "init" }
  set e to {"quit", "kill", "end", "exit"}


  set b to {"break"}
  set w to {"work"}
  set r to {"reset", "punt"}

  tell application "BreakTime"
    if q is in e then
      set msg to "Quit BreakTime"
      quit
    else if q is in s then
      set msg to "BreakTime started"
      activate
    end if
  end tell
end alfred_script