# [rocker-project.org](https://rocker-project.org)

A [website](https://rocker-project.org) for the Rocker Project.

## Contributing

Feedbacks & contributions are welcome!

If you find a documentation issue, please open an issue this repository
or edit the Markdown file included in this repository and open a PullRequest.

When the PullRequest is merged, the website is updated by GitHub Actions.

## Local build

Install [Quarto CLI](https://quarto.org/docs/get-started/) and run the folloing command.

```sh
quarto preview
```

Then, the website is displayed on the local web server,
and the generated website is located in the `docs` directory.

Note that, the Quarto CLI version which build the deployed website
may be specified in [the GitHub Actions workflow definition file](.github/workflows/main.yml).
