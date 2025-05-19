#!/bin/bash

output=$(mbsync -a 2>&1)
status=$?

echo "$(date) - Exit: $status" >> ~/.mbsync_cron.log
echo "$output" >> ~/.mbsync_cron.log

if [ $status -ne 0 ]; then
  echo "[mbsync failed] $output" > ~/.mail_alert
  exit 1
fi

new_mail_count=$(find ~/Mail/ -type d -name new | xargs -r find -type f | wc -l)

if [ "$new_mail_count" -gt 0 ]; then
  echo "[📬 New Mail] You have $new_mail_count new message(s) - $(date)" > ~/.mail_alert
fi
