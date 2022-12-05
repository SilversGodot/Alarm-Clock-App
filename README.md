# Alarm-Clock-App

## Project Description:
iOS alarm clock app that is able to play a .wav file or youtube link as the alarm sound. Able to start mid-file and repeat at any point.

## Detailed Requirements:
- Accepts .wav file as input and uses it as the alarm sound. File is obtained from iCloud.
- Alarms can have customized snooze length.
- Able to start the alarm from the middle of the song and repeat at an arbitrary endpoint, or possibly just terminate.
- Able to pull song from a youtube link. Possibly cache the song on-device so a wifi connection is not necessary.
- Alarms can be cancelled early. E.g., if you wake up 5 minutes before the alarm, you can close it so it doesn't go off.

## Discovered Limitations:
- Apple does not allow interruption of the screen, as is with their alarm clock app; we can only use notifications
- Notifications do not allow sounds to play beyond 30 seconds; there is no workaround
- iCloud support requires a paid membership; for this project, we can be satisfied with downloading from a link

## To do:
- Snooze function (able to snooze from a notification)
- File truncation/repeat functionality (may not be possible, but would take a lot of time potentially)

## Deadlines:
- Project description: 10/21
- Project proposal presentation: 10/23
- Project update presentation: 11/15
- Final Project Code: 12/5

## Team Members:
- Neal Huang
- Khushi Patel
- Michale Kncheloe
- Sharyliz Reid
