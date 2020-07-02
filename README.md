# NeverFap Deluxe Website

Website: https://neverfapdeluxe.com/

This is the official repository for the NeverFap Deluxe website.

Please feel free to learn from the codebase, I wanted to release the source-code so others can learn from how it's all built!

Released under the [GNU GPLv3 licence](https://github.com/neverfap-deluxe/nfd-app/blob/master/LICENSE).


## Tech

Frontend: HTML, SCSS, Vanilla Javascript, Eex Templating
Backend: Phoenix Framework, Postgres, Amazon SES
Authentication: Pow
Deployment: Travis CI, Docker, Digital Ocean

There's a heap of additional tech, libraries and different complex generators under the hood, however that's the basics of it!


## Local Setup

NOTE: Rewrite these instructions.

- You'll need to download node.js, postgres and phoenix framework to your computer in order to run this project.
- You'll need to download, setup and run the nfd-api application on your local environment as well, since that's where all the content is stored.
- Once this is setup, go into `/assets` and run `npm install` in order to download all the frontend dependencies.

- In order to run this, go into the project root folder.
- `mix ecto.reset` will setup the database with the correct tables.
- `source .env` will set it up (for whatever reason, I need to keep doing it.)
- `mix phx.server` will run the application.
- (with your .env file that you source, don't forget to make it export VAR='arstarst')

## Create nfd_dev postgres database

- Setup postgres
- `psql -U postgres`
- `CREATE DATABASE nfd_dev;`
<!-- - `CREATE USER nfd WITH ENCRYPTED PASSWORD 'nfd_password';`
- `GRANT ALL PRIVILEGES ON DATABASE nfd_dev TO nfd;` -->
- mix ecto.migrate

## Deployment.

- Work on `master` push on `production` branches.
- First setup travis encryption https://github.com/dwyl/learn-travis/blob/master/encrypted-ssh-keys-deployment.md
- Make changes to `production` branch.
- Push to master.

## How It Works

Essentially it can help to think of the web app as a complicated backend shell which serves all the content from an external API.

So what does this shell do exactly?

- It manages all the user authentication stuff for access to the dashboard
- It stores all the data related to users, analytics and paid courses authentication
- I've built a significant subscriber system into the shell, which is also designed to send emails to users


## Contributions

We are actively looking for people to help build NeverFap Deluxe! If you're interested, please get in touch~! We need people to:

- Help write documentation into the code (and this README.md)
- People to QA all the features on the website and report bugs
- Build stuff that you think might be useful

Pitch your ideas and I'll be more than happy to listen :D


## Create nfd_dev postgres database

- Setup postgres
- `psql -U postgres`
- `CREATE DB nfd_dev;`
- mix ecto.migrate

## Migrate

TODO
