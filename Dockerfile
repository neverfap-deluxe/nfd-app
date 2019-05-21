FROM elixir:1.8.1-alpine as build

ENV MIX_ENV=prod
ENV PORT=4000

ARG AWS_ACCESS_KEY
ARG AWS_SECRET_KEY
ARG JSON_API
ARG HOST
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB
ARG POSTGRES_HOST
ARG SECRET_KEY_BASE

WORKDIR /app
COPY . .

RUN apk update && \
    apk add -u musl musl-dev musl-utils nodejs-npm build-base python2

RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix hex.info

RUN mix deps.get --only prod

RUN mix compile
RUN cd assets && \
    npm install && \
    npm rebuild node-sass --force && \
    npm run deploy && \
    cd .. && \
    mix phx.digest

    # NOTE: Will need to remove --watch from the commands.
    # npm run mjml \
    # npm run k \


EXPOSE 4000

# CMD ["mix", "do", "ecto.create,", "ecto.migrate,", "run priv/repo/seeds.exs,", "phx.server"]
# CMD ["mix", "do", "ecto.setup,", "phx.server"]

# The iex actually doeComprehensive NoFap Guides nothing.
CMD ["iex", "-S", "mix", "do", "ecto.prod,", "phx.server"]


