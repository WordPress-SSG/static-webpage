#!/bin/bash

echo "Starting website fetch for $DOMAIN"

wget -vv --no-check-certificate --reject-regex="/wp-content/uploads/|add-to-cart|/wp-json/" -nc \
 --user-agent="$USERAGENT" \
 --recursive --page-requisites --adjust-extension --span-hosts \
 --domains "$DOMAIN" --restrict-file-names=unix --convert-links --max-redirect 5 "http://$DOMAIN"

echo "Website fetch completed!"
