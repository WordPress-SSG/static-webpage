#!/bin/bash

echo "Starting website fetch for $DOMAIN"

wget -vv --no-check-certificate --reject-regex="/wp-content/uploads/|add-to-cart|/wp-json/" -nc \
 --user-agent="$USERAGENT" \
 --recursive --page-requisites --adjust-extension --span-hosts \
 --domains "$DOMAIN" --restrict-file-names=unix --convert-links --max-redirect 5 "http://$DOMAIN"

# Function to sync files
sync_files() {
    local SRC_DIR="$1"
    local DEST_DIR="$2"
    
    # Ensure the destination directory exists
    mkdir -p "$DEST_DIR"
    
    rsync -av --include="*/" --include="*.js" --include="*.css" --include="*.jpg" --include="*.png" --include="*.gif" --exclude="*" "$SRC_DIR/" "$DEST_DIR/"
}

# Call the function with arguments
sync_files "/wp-ssg/plugins" "/data/$DOMAIN/wp-content/plugins"
sync_files "/tmp/contents/wp-content-$DOMAIN-unzipped/var/www/html/wp-content" "/data/$DOMAIN/wp-content"

echo "JavaScript and CSS files have been copied successfully!"

echo "Website fetch completed!"
