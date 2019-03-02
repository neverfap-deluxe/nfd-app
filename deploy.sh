#!/bin/sh

# nginx docker-compose.yml file
echo 'echo rsync nginx/docker-compose.yml'
rsync -r --delete-after --quiet $TRAVIS_BUILD_DIR/nginx/docker-compose.yml root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production

# nginx.conf file
echo 'echo rsync nginx/nginx.conf'
rsync -r --delete-after --quiet $TRAVIS_BUILD_DIR/nginx/nginx.conf root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production

ssh root@198.199.67.180 <<EOF
  echo "docker pull dottjt/nfd-app"
  docker pull dottjt/nfd-app

  echo "echo cd /docker/letsencrypt-docker-nginx/src/production/" 
  cd /docker/letsencrypt-docker-nginx/src/production/ 
  
  echo "echo docker-compose down"
  docker-compose down 
  
  echo "echo docker-compose up -d"
  docker-compose up -d 
  
  echo "echo exit"
  exit
EOF

echo 'all done!'
