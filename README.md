[![](https://raw.githubusercontent.com/emmercm/docker-flexget/assets/flexget.png)](https://flexget.com/)

[![](https://badgen.net/badge/emmercm/flexget/blue?icon=docker)](https://hub.docker.com/r/emmercm/flexget)
[![](https://badgen.net/docker/pulls/emmercm/flexget?icon=docker)](https://hub.docker.com/r/emmercm/flexget)

[![](https://badgen.net/badge/emmercm/docker-flexget/purple?icon=github)](https://github.com/emmercm/docker-flexget)
[![](https://badgen.net/circleci/github/emmercm/docker-flexget/master?icon=circleci)](https://github.com/emmercm/docker-flexget/blob/master/.circleci/config.yml)
[![](https://badgen.net/github/license/emmercm/docker-flexget?color=grey)](https://github.com/emmercm/docker-flexget/blob/master/LICENSE)

FlexGet daemon with remote web interface.

# Supported tags

| Tags | Size / Layers |
|-|-|
| `2.21`, `2.21-alpine`, `2`, `2-alpine`, `latest` | [![](https://images.microbadger.com/badges/image/emmercm/flexget:2.21.svg)](https://microbadger.com/images/emmercm/flexget:2.21 "Get your own image badge on microbadger.com") |
| `2.20`, `2.20-alpine` | [![](https://images.microbadger.com/badges/image/emmercm/flexget:2.20.svg)](https://microbadger.com/images/emmercm/flexget:2.20 "Get your own image badge on microbadger.com") |
| `2.19`, `2.19-alpine` | [![](https://images.microbadger.com/badges/image/emmercm/flexget:2.19.svg)](https://microbadger.com/images/emmercm/flexget:2.19 "Get your own image badge on microbadger.com") |
| `2.18`, `2.18-alpine` | [![](https://images.microbadger.com/badges/image/emmercm/flexget:2.18.svg)](https://microbadger.com/images/emmercm/flexget:2.18 "Get your own image badge on microbadger.com") |
| `2.17`, `2.17-alpine` | [![](https://images.microbadger.com/badges/image/emmercm/flexget:2.17.svg)](https://microbadger.com/images/emmercm/flexget:2.17 "Get your own image badge on microbadger.com") |

# What is FlexGet?

From [flexget.com](https://flexget.com/):

> _FlexGet is a multipurpose automation tool for content like torrents, nzbs, podcasts, comics, series, movies, etc. It can use different kinds of sources like RSS-feeds, html pages, csv files, search engines and there are even plugins for sites that do not provide any kind of useful feeds._

FlexGet is released under the [MIT License](https://github.com/Flexget/Flexget/blob/develop/LICENSE) for broad permissions.

# How to use these images

The images do not require any external Docker networks, volumes, environment variables, or arguments and can be run with just:

```bash
docker run emmercm/flexget
```

But it is highly encouraged to mount the `/config` volume.

## Volume mounts

Due to the ephemeral nature of Docker containers these images provide a volume mount at `/config` to persist data outside of the container. `/config` contains `config.yml` and the FlexGet database.

Usage:

```bash
docker run \
    --volume "$PWD/config:/config" \
    emmercm/flexget
```

## Web UI

FlexGet has a web UI that can be accessed at [http://localhost:5050](http://localhost:5050) with the default username `flexget` and password `flexgetindocker`.

Usage:

```bash
docker run \
    --publish 5050:5050
    emmercm/flexget
```

## Environment Variables

To change the timezone of the container set the `TZ` environment variable. The full list of available options can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

# Image variants

## `emmercm/flexget:<version>-alpine`

The default image variant, these images are based on [the `alpine` official image](https://hub.docker.com/_/alpine) which is designed to be "small, simple, and secure." This variant is recommended for when final image size is a concern.

# License

This project is under the [GNU Generic Public License v3](https://github.com/emmercm/docker-flexget/blob/master/LICENSE) to allow free use while ensuring it stays open.
