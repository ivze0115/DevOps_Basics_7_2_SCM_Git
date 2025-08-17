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

# create necessary directories if not exist
mkdir -p "$backup_dir" "$old_backup_dir" "$log_dir"

# log files
log_file="$log_dir/backup.log"
err_log_file="$log_dir/err_backup.log"

{
    echo "[$(date '+%F %T')] Starting backup process..."

     # Move old archives (older than 3 minutes)
    find "$backup_dir" -type f -mmin +3 -name "*.tar.gz" -exec mv {} "$old_backup_dir" \;

    echo "Completed. Archives stored in $backup_dir, old archives moved to $old_backup_dir"


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


} >>"$log_file" 2>>"$err_log_file"

