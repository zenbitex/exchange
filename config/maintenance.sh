#!/bin/bash

if [ "$1" == "off" ]; then
  echo "switch off maintenance mode"
  ln -sf /home/zenbitex/zenbitex-exchange/config/nginx.conf /etc/nginx/conf.d/zenbitex.conf
  mv /home/zenbitex/zenbitex-exchange/public/404.html.old /home/zenbitex/zenbitex-exchange/public/404.html
  service nginx reload
else
  echo "switch on maintenance mode"
  ln -sf /home/zenbitex/zenbitex-exchange/config/nginx_maintenance.conf /etc/nginx/conf.d/zenbitex.conf
  mv /home/zenbitex/zenbitex-exchange/public/404.html /home/zenbitex/zenbitex-exchange/public/404.html.old
  cp /home/zenbitex/zenbitex-exchange/public/503.html /home/zenbitex/zenbitex-exchange/public/404.html
  service nginx reload
fi
