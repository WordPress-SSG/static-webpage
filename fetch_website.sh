#!/bin/bash

echo "Starting website fetch for $DOMAIN"

wget -vv --no-check-certificate --reject-regex="/wp-content/uploads/|add-to-cart|/wp-json/" -nc \
 --user-agent="$USERAGENT" \
 --recursive --page-requisites --adjust-extension --span-hosts \
 --domains "$DOMAIN" --restrict-file-names=unix --convert-links --max-redirect 5 "http://$DOMAIN"

# Source and destination directories
SRC_DIR="/wp-ssg/plugins"
DEST_DIR="/data/$DOMAIN/wp-content/plugins"

# Ensure the destination directory exists
mkdir -p "$DEST_DIR"

# Find and copy .js, .css, and image files while preserving directory structure
rsync -av --include="*/" --include="*.js" --include="*.css" --include="*.jpg" --include="*.png" --include="*.gif" --exclude="*" "$SRC_DIR/" "$DEST_DIR/"

echo "JavaScript and CSS files have been copied successfully!"

echo "Website fetch completed!"
