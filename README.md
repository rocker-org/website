# [rocker-project.org](https://rocker-project.org)

A [website](https://rocker-project.org) for the Rocker Project.

## Contributing

Feedbacks & contributions are welcome!

If you find a documentation issue, please open an issue this repository
or edit the Markdown file included in this repository and open a Pull Request.

When the PullRequest is merged, the website is updated by GitHub Actions.

## Local build

### quarto cli

Install [Quarto CLI](https://quarto.org/docs/get-started/) and run the following command.

```sh
quarto preview
```

Then, the website is displayed on the local web server,
and the generated website is located in the `docs` directory.

Note that, the Quarto CLI version which build the deployed website
may be specified in [the GitHub Actions workflow definition file](.github/workflows/main.yml).

### docker compose

You can use a Docker container instead of installing quarto cli locally
with following [docker compose](https://docs.docker.com/compose/) command.

```sh
docker compose up
```

Then, open `localhost:8000` to preview the website.

Once you have finished checking, you can delete the images and the container with the following command.

```sh
docker compose down --rmi all
```
