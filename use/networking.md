---
title: Networking
description: Connect R containers to reverse proxy servers and DBs.
aliases:
  - /use/networking/
---

## HTTPS

Any RStudio instance on a remote server is accessed over an unencrypted http by default
(though RStudio encrypts the password entered to log in through client-side javascript).

The easiest way to connect over a secure https connection is to use a reverse proxy server,
such as [Caddy](https://caddyserver.com).
To establish an encrypted https connection, you must first have control of a registered domain name:
https cannot be used when connecting directly to a given ip address.
Once you have pointed your domain name at the ip address of the server, Caddy provides a quick way to get set up with https using Let's Encrypt certificates.

Below is an example [Caddyfile](https://caddyserver.com/docs/caddyfile) specifying the necessary configuration,
along with a [compose file](https://docs.docker.com/compose/compose-file/)
which sets up an RStudio server instance behind a separate container running Caddy 2.
You can access the RStudio Server on `https://rstudio.example.com`.
This approach also makes it easy to map ports to subdomains for cleaner-looking URLs:

Example Caddyfile:

```default
{
  you@email.com
}

rstudio.example.com {
  reverse_proxy rstudio:8787
}
```

Example compose file:

```yml
services:
  caddy:
    image: caddy:2
    restart: unless-stopped
    depends_on:
      - rstudio
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile:ro
      - caddy_data:/data
      - caddy_config:/config
    ports:
      - 80:80
      - 443:443

  rstudio:
    image: rocker/verse:4
    restart: unless-stopped
    env_file: .rstudio.env
    expose:
      - 8787

volumes:
  caddy_data:
    external: true
  caddy_config:
```

Example .rstudio.env file:

```default
PASSWORD=yourpassword
```

More details about the use of [docker compose](https://docs.docker.com/compose/) and [Caddy Server](https://caddyserver.com/) are found on their websites.

## Linking database containers

Here is an example of a compose file that configures a Shiny Server that can connect to a database (PostgreSQL).

```yml
services:
  db:
    image: postgres:13
    restart: always
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    volumes:
      - pgdata:/var/lib/postgresql/data
    expose:
      - 5432

  shiny:
    image: rocker/shiny-verse:4
    restart: always
    environment:
      DB_HOST: db
      DB_PORT: 5432
    depends_on:
      - db
    volumes:
      - ./app/app.R:/srv/shiny-server/app/app.R:ro
    ports:
      - 3838:3838

volumes:
  pgdata:
```
