#!/bin/bash

export DISPLAY=:0
# Use dmenu and fzf to select an executable file
file=$(dmenu_path | fzf)

# Check if a file was selected
if [ -z "$file" ]; then
    # echo "No file selected."
    exit 1
fi

# Execute the selected file in the background
nohup setsid $file > /dev/null 2>&1 &
job_pid=$!

# Wait briefly to ensure the job is listed
sleep 0.1

# Print the list of jobs
# jobs

# Disown the job using its PID
disown $job_pid

# echo "Job $job_pid has been disowned."
