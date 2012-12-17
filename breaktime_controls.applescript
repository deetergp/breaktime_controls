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
  set s to {"start", "init" }
  set e to {"quit", "exit"}


  set b to {"break"}
  set w to {"work"}
  set r to {"reset", "reschedule"}

  set dis to {"off"}
  set en to {"on"}

  tell application "BreakTime"
    if q is in e then
      set msg to "Take care till next time."
      quit
    else if q is in s then
      set msg to "Application started"
      activate
    else if q is in b then
      set msg to "Take a break."
      start_break
    else if q is in w
      set msg to "Back to work!"
      end_break
    else if q is in r then
      set msg to "Need… More… TIME!"
      reschedule_break
    else if q is in dis then
      set msg to "Disabled"
      set enabled to not enabled
    else if q is in en then
      set msg to "Enabled"
      set enabled to true
    end if
  end tell

  if msg is not equal to "" then
    sendMsg(msg)
  end if
end alfred_script