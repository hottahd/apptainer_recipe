#!/bin/bash

cd "$(dirname "$0")"

src='.'
base_dest="$HOME/Dropbox/Projects"
year_file="./.backup_start_year"
project_file="./.project_name"
project_finish_flag_file="./.project_done"

if [ ! -f "$project_file" ]; then
    # プロジェクト名を入力して記録
    read -p "input project name for backup: " project_name
    echo "$project_name" > "$project_file"
else
    project_name=$(cat $project_file)
fi

if [ ! -f "$year_file" ]; then
    current_year=$(date +%Y)
    echo $current_year > $year_file
else
    current_year=$(cat $year_file)
fi

cron_identifier="# BACKUP_PROJECT_CRON_${current_year}_${project_name}" # cronジョブ識別コメント

dest="$base_dest/$current_year/$project_name"
mkdir -p $dest
log_file="$dest/backup.log"

# プロジェクト終了チェック
if [ -f "$project_finish_flag_file" ]; then
    echo "Project marked as done. Stopping backup."

    # cronジョブを削除
    crontab -l | grep -v "$cron_identifier" | crontab -
    echo "Cron job removed."

    # ログ出力
    echo "$(date): Backup stopped for project '$project_name'" >> "$log_file"

    # フラグファイルを削除して確認
    rm -f "$project_finish_flag_file"
    echo "$(date): Project done flag removed: '$project_finish_flag_file'" >> "$log_file"

    exit 0
fi


# rsync
echo "$(date): Starting backup from '$src' to '$dest'" >> "$log_file"
if rsync -av --delete "$src" "$dest"; then
    echo "$(date): Backup completed successfully to '$dest'" >> "$log_file"
else
    echo "$(date): Backup failed to '$dest'" >> "$log_file"
    exit 1
fi

# cronジョブの自動登録（初回のみ）
if ! crontab -l 2>/dev/null | grep -q "$cron_identifier"; then
    echo "Setting up cron job for automatic backups every 6 hours."

    # cronジョブ内容を追加
    cron_job="0 */6 * * * $PWD/$(basename "$0") >> /var/log/rsync_to_dropbox.log 2>&1 $cron_identifier"
    (crontab -l 2>/dev/null || true; echo "$cron_job") | crontab -
fi