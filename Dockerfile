FROM node:12
MAINTAINER Andrew Grosser <dioptre@gmail.com>

ARG NODE_ENV="production"

ENV POSTGRES_HOST localhost
ENV POSTGRES_PASSWORD password
ENV POSTGRES_USER postgres
ENV POSTGRES_DB sfpl
ENV POSTGRES_PORT=5432
ENV POSTGRES_SSL=0

ARG NODE_ENV

EXPOSE 5000

RUN apt update \
      && apt install -y --no-install-recommends \
            libgdal-dev build-essential wget postgresql-client libxml2-dev\
            sudo \
            supervisor \
            netcat\
      && rm -rf /var/lib/apt/lists/*

COPY supervisor.conf /etc/supervisor.conf
COPY gphile.supervisor.conf /etc/supervisor/conf.d/gphile.supervisor.conf

# Install yarn ASAP because it's the slowest
WORKDIR /app/
ADD . /app/
RUN yarn global add postgraphile --frozen-lockfile --production=true --no-progress
#RUN yarn install --frozen-lockfile --production=true --no-progress

LABEL description="PostGraphile"

# You might want to disable GRAPHILE_TURBO if you have issues
ENV GRAPHILE_TURBO=1
ENV NODE_ENV=$NODE_ENV
CMD bash dockercmd.sh