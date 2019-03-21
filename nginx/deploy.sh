#!/bin/sh

ssh root@198.199.67.180 <<EOF
  echo "docker pull dottjt/nfd-app"
  docker pull dottjt/nfd-app

  echo "echo cd /docker/letsencrypt-docker-nginx/src/production/" 
  cd /docker/letsencrypt-docker-nginx/src/production/ 
  
  echo "source .env"
  source .env

  echo "echo y | docker image prune -a"
  docker image prune -af

  echo "echo docker-compose down"
  docker-compose down 
  
  echo "echo docker-compose up -d"
  docker-compose up -d 
  
  echo "echo exit"
  exit
EOF

echo 'all done!'
