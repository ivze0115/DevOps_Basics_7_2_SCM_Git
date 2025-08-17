#!/bin/bash

# current date in format YYYY-MM-DD
current_date=$(date +%F)

# source directory
src_dir=~/linux_p2
# backup directory
backup_dir="$src_dir/backup"
# old backup directory
old_backup_dir="$src_dir/old_backup"
# log directory
log_dir="$src_dir/log"

s3_bucket="s3://ivze0115-ec2-backup-bucket-2025"

# create necessary directories if not exist
mkdir -p "$backup_dir" "$old_backup_dir" "$log_dir"

# log files
log_file="$log_dir/backup.log"
err_log_file="$log_dir/err_backup.log"

{
    echo "[$(date '+%F %T')] Starting backup process..."


# Move archives older than 3 minutes to old_backup
find "$backup_dir" -type f -mmin +3 -exec mv {} "$old_backup_dir" \;

# Upload to AWS S3 using instance profile credentials
aws s3 cp "$old_backup_dir" "$s3_bucket/old_backup/" --recursive


echo "Completed. Archives stored in $backup_dir, old archives moved to $s3_bucket"


    # Loop through *.txt files
    for file in "$src_dir"/*.txt; do
        if [[ -f "$file" ]]; then
            echo "Processing: $(basename "$file")"
            archive_name="$(basename "$file")_${current_date}.tar.gz"
            if tar -czf "$backup_dir/$archive_name" -C "$src_dir" "$(basename "$file")"; then
                echo "Archived: $archive_name"
            else
                echo "Error archiving $file" >&2
            fi
        fi
    done


# Upload to AWS S3 using instance profile credentials
aws s3 cp "$backup_dir" "$s3_bucket/backup/" --recursive 

echo "Completed. Archives stored in $backup_dir and uploaded to $s3_bucket"

} >>"$log_file" 2>>"$err_log_file"

