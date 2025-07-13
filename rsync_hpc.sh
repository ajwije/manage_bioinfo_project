#!/bin/bash

# Configuration - modify these variables according to your needs
LOCAL_DIR="/Users/aselawijeratne/Documents/Projects/2024_ITS_mock"  # Local directory to sync
REMOTE_USER="your_hpc_username"  # Your HPC username
REMOTE_HOST="your_hpc_host"  # Your HPC host address
REMOTE_DIR="/path/to/remote/dir"  # Remote directory on HPC

# Function to perform rsync
function sync_with_hpc {
    echo "Starting rsync to HPC..."
    rsync -avz --progress \
        --exclude='.git/' \
        --exclude='.DS_Store' \
        --exclude='*.raw' \
        --exclude='*.img' \
        --exclude='*.dat' \
        --exclude='*.bin' \
        --exclude='*.npy' \
        --exclude='*.h5' \
        --exclude='*.hdf5' \
        --exclude='*.fits' \
        --exclude='*.nc' \
        --max-size=1G \
        $LOCAL_DIR/ \
        ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
    
    if [ $? -eq 0 ]; then
        echo "Sync completed successfully!"
    else
        echo "Error occurred during sync!"
        exit 1
    fi
}

# Function to set up daily reminder
echo "Setting up daily reminder for HPC sync..."

# Create reminder for 5 PM (17:00)
REMINDER_TIME="17:00"
REMINDER_MESSAGE="Don't forget to sync your files with HPC!"

# Add reminder to crontab
crontab -l > mycron
# Add new cron job
echo "0 17 * * * osascript -e 'display notification \"${REMINDER_MESSAGE}\" with title \"HPC Sync Reminder\"'" >> mycron
# Install new cron file
crontab mycron
rm mycron

echo "Daily reminder set for $REMINDER_TIME"
echo "You can manually run the sync anytime by executing:"
echo "./rsync_hpc.sh sync"

# If script is called with 'sync' argument, perform sync immediately
if [ "$1" = "sync" ]; then
    sync_with_hpc
fi
