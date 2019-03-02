# nginx docker-compose.yml file
echo 'echo rsync nginx/docker-compose.yml'
rsync -r --delete-after --quiet ./nginx/docker-compose.yml root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production

# # nginx.conf file
# echo 'echo rsync nginx/nginx.conf'
# rsync -r --delete-after --quiet ./nginx/nginx.conf root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production/


# # nginx-test.conf file
echo 'echo rsync nginx/nginx-test.conf'
rsync -r --delete-after --quiet ./nginx/nginx-test.conf root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production/nginx.conf


# .env file
echo 'echo rsync nginx/.env'
rsync -r --delete-after --quiet ./nginx/.env root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production/.env

git add .
git commit -m "$1"
git push