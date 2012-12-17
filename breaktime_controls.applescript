### Controls ###
# Begin your break: bt break
# End your break: bt work
# Begin BreakTime: bt start or bt enable
# Quit BreakTime: bt end or bt disable or bt quit
# Reset countdown to break: bt reset or bt punt

on sendMsg(msg)
  tell application "System Events"
    set isRunning to (count of (every process whose bundle identifiedr is "com.Growl.GrowlHelperApp"
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
  set s to {"start", "enable"}
  set e to {"end", "quit", "disable"}
    set b to {"break"}
  set w to {"work"}
  set r to {"reset", "punt"}

  tell application "BreakTime"
    if q is in w then
      end_break
    else if q is in b then
      start_break
    else if q is in r then
      reschedule_break
      set msg to "BreakTime rescheduled"
    end if
  end tell
end alfred_script