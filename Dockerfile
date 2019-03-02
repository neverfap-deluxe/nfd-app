FROM elixir:1.8.1-alpine as build

ENV MIX_ENV=prod
ENV PORT=4000

WORKDIR /app
COPY . .

RUN apk update && \
    apk add -u musl musl-dev musl-utils nodejs-npm build-base python2

RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix hex.info

RUN mix deps.get --only prod
# You can't do this here, because docker doesn't exist at this point.
# RUN mix ecto.create && mix ecto.migrate

RUN mix compile
RUN cd assets && \
    npm install && \
    npm rebuild node-sass --force && \
    npm run deploy && \
    cd .. && \
    mix phx.digest

EXPOSE 4000
# CMD ["./run.sh"]
# CMD ["mix", "phx.server"]
CMD ["mix", "do", "ecto.create,", "ecto.migrate,", "phx.server"]
