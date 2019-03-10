# NeverFap Deluxe Web App

## To build the 


- Todo, will need to set env

make build
// will build production image.




$ docker exec --interactive --tty example_web_1 /bin/bash
> mix phoenix.gen.model User users name:string
> mix ecto.migrate

CMD [“mix”, “do”, “ecto.create,”, “ecto.migrate,”, “phoenix.server”]


# Setup 
https://docs.travis-ci.com/user/encryption-keys/
https://github.com/dwyl/learn-travis/blob/master/encrypted-ssh-keys-deployment.md
https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/to-existing-droplet/

https://www.humankode.com/ssl/how-to-set-up-free-ssl-certificates-from-lets-encrypt-using-docker-and-nginx

sudo mkdir -p /docker/letsencrypt-docker-nginx/src/letsencrypt/neverfapdeluxe.com
sudo vim /docker/letsencrypt-docker-nginx/src/letsencrypt/docker-compose.yml
<!-- File in /letsencrypt on this folder -->

sudo vim /docker/letsencrypt-docker-nginx/src/letsencrypt/nginx.conf
sudo vim /docker/letsencrypt-docker-nginx/src/letsencrypt/neverfapdeluxe.com/index.html

cd /docker/letsencrypt-docker-nginx/src/letsencrypt
sudo docker-compose up -d



<!-- Test -->
sudo docker run -it --rm \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/neverfapdeluxe.com:/data/letsencrypt \
-v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
certbot/certbot \
certonly --webroot \
--register-unsafely-without-email --agree-tos \
--webroot-path=/data/letsencrypt \
--staging \
-d test.neverfapdeluxe.com


sudo rm -rf /docker-volumes/


<!-- Actual production -->

sudo docker run -it --rm \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/neverfapdeluxe.com:/data/letsencrypt \
-v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
certbot/certbot \
certonly --webroot \
--email julius.reade@gmail.com --agree-tos --no-eff-email \
--webroot-path=/data/letsencrypt \
-d test.neverfapdeluxe.com


<!-- If successful, take it down -->

cd /docker/letsencrypt-docker-nginx/src/letsencrypt

sudo docker-compose down


sudo mkdir -p /docker/letsencrypt-docker-nginx/src/production/neverfapdeluxe.com
sudo mkdir -p /docker/letsencrypt-docker-nginx/src/production/dh-param



# Installing Travis
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /Users/matt/.rvm/scripts/rvm
gem install travis



# Build nfd-app


# Run nfd-app


	docker build --build-arg APP_NAME=$(APP_NAME) \
		--build-arg APP_VSN=$(APP_VSN) \
		-t $(APP_NAME):$(APP_VSN)-$(BUILD) \
		-t $(APP_NAME):latest .

run: ## Run the app in Docker
	docker run --env-file config/docker.env \
		--expose 4000 -p 4000:4000 \
		--rm -it $(APP_NAME):latest
\



<!-- staging -->
sudo docker run -it --rm \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/neverfapdeluxe.com:/data/letsencrypt \
-v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
certbot/certbot \
certonly --webroot \
--register-unsafely-without-email --agree-tos \
--webroot-path=/data/letsencrypt \
--staging \
-d neverfapdeluxe.com -d www.neverfapdeluxe.com




<!-- prod -->
sudo docker run -it --rm \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/neverfapdeluxe.com:/data/letsencrypt \
-v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
certbot/certbot \
certonly --webroot \
--email neverfapdeluxe@gmail.com --agree-tos --no-eff-email \
--webroot-path=/data/letsencrypt \
-d neverfapdeluxe.com -d www.neverfapdeluxe.com
