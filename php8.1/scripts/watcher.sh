#!/bin/bash

WATCH_FOLDER=/var/www/nginx

inotifywait -rmq --event modify --event create --event delete ${WATCH_FOLDER} | \
  while read dir evt file; do
    # Ignore specified extensions
    if [[ ! $file =~ .*(swp|swx|~)$ ]]; then 
      echo "Nginx configuration changed"
      nginx -t
      if [ $? -eq 0 ]; then
        echo "Nginx tested successfully"
        /usr/sbin/nginx -s reload
        if [ -z "`/bin/pidof nginx`" ]; then
          echo "Nginx reload failed!"
        else
          echo "Nginx reloaded."
          /usr/sbin/nginx -s reload
        fi
      else
        echo "Nginx test FAILED!" >> /dev/stdout
      fi
    fi
  done