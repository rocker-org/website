---
title: Networking
description: Connect R containers to networks.
aliases:
  - /use/networking/
filters:
  - code-filename
---

## Corporate Proxy

If you are behind a corporate proxy,
you will need to set up a proxy to the container in order to connect the Docker container to the Internet.

By setting it up as described in [the official documentation](https://docs.docker.com/network/proxy/),
environment variables are set in the container, and many tools, including R,
will use these environment variables to connect to the Internet.

However, RStudio Server and Shiny Server do not respect container environment variables.
This may prevent you from connecting to the Internet from RStudio IDE.
If you want to use environment variables in sessions within these servers,
you must write the variables to a `Renviron` file.

:::{.callout-tip}

[`rocker/rstudio`](../images/versioned/rstudio.md) and [`rocker/shiny`](../images/versioned/shiny.md)
avoid the problem of RStudio Server and Shiny Server not recognizing container environment variables
by writing them to `Renviron.site` at container startup.

:::

If you need to configure proxy settings directly in the `Renviron` file,
it is possible to configure only one `ALL_PROXY` setting instead of writing `HTTP_PROXY` and `HTTPS_PROXY` respectively.

```{.default filename=".Renviron"}
ALL_PROXY=http://192.168.1.12:3128
```

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

```{.default filename="Caddyfile"}
{
  you@email.com
}

rstudio.example.com {
  reverse_proxy rstudio:8787
}
```

```{.yml filename="compose.yml"}
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

In this example, the environment variable used in the rstudio container are set in the following `.env` file.

```{.sh filename=".rstudio.env"}
PASSWORD=yourpassword
```

More details about the use of [docker compose](https://docs.docker.com/compose/) and [Caddy Server](https://caddyserver.com/) are found on their websites.

## Linking database containers

Here is an example of a compose file that configures a Shiny Server that can connect to a database (PostgreSQL).

```{.yml filename="compose.yml"}
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
