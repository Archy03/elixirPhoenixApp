FROM elixir:latest

RUN apt-get update && \
    apt-get install -y \
    inotify-tools

EXPOSE 4000

WORKDIR /app

RUN \
    curl -fsSL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs

RUN npm install -g yarn

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new 1.5.12 --force
