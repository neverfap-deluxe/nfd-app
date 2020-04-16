# nginx docker-compose.yml file
# echo 'echo rsync nginx/docker-compose.yml'
# rsync -r --delete-after --quiet ./nginx/docker-compose.yml root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production/docker-compose.yml
# This wasn't commented out before, but ./nginx/docker-compose.yml also doesn't exist? Wierd (17-04-2020)

# # nginx.conf file
# echo 'echo rsync nginx/nginx-prod.conf'
# rsync -r --delete-after --quiet ./nginx/nginx-prod.conf root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production/nginx.conf

# # # nginx-test.conf file
# echo 'echo rsync nginx/nginx-test.conf'
# rsync -r --delete-after --quiet ./nginx/nginx-test.conf root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production/nginx.conf

# .env file
echo 'echo rsync nginx/.env'
rsync -r --delete-after --quiet ./nginx/.env root@198.199.67.180:/docker/letsencrypt-docker-nginx/src/production/.env

git add -u
git reset -- config/dev.exs
git commit -m "$1"
git push