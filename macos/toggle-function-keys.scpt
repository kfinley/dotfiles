-- Apple Script (i.e. Use in Apple's Script Editor Application) to Toggle Function Keys / Media keys on/off
-- Tested on MacOS Big Sur (11.4) June 2021
-- Project Path: https://github.com/MrSimonC/Toggle-Mac-Function-Keys

on run argv

    set touchBarShows to item 1 of argv

    tell application "System Preferences"
        set current pane to pane "com.apple.preference.keyboard"
    end tell

    tell application "System Events"
        if UI elements enabled then
            tell application process "System Preferences"
                repeat until exists tab group 1 of window "Keyboard"
                    delay 0.5
                end repeat
                click radio button "Keyboard" of tab group 1 of window "Keyboard"
                
                -- Make a selection from the popupbutton.
                click pop up button 2 of tab group 1 of window "Keyboard"

                -- F1, F2, etc. Keys
                click menu item touchBarShows of menu 1 of pop up button 2 of tab group 1 of window "Keyboard"
                

                try
                    click checkbox "Use F1, F2, etc. keys as standard function keys on external keyboards" of tab group 1 of window "Keyboard"
                end try
                try
                    click checkbox "Use F1, F2, etc. keys as standard function keys" of tab group 1 of window "Keyboard"
                end try
            end tell
            tell application "System Preferences" to quit
        else
            -- GUI scripting not enabled.  Display an alert
            tell application "System Preferences"
                activate
                set current pane to pane "com.apple.preference.security"
                display dialog "UI element scripting is not enabled. Please activate this app under Privacy -> Accessibility so it can access the settings it needs."
            end tell
        end if
    end tell

end run
