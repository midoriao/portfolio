# sotasato-www

My portfolio page.

GitHub Pages target: <https://midoriao.github.io/portfolio/>

## Usage

To build and launch a local server on port `8000`,

```console
$ make build
$ make serve
```

## Publishing

This repository publishes with GitHub Pages via GitHub Actions.

1. In the repository settings, open `Pages`.
2. Set `Source` to `GitHub Actions`.
3. Push to the `main` branch.

The workflow builds the site into `public/` and deploys it to:

<https://midoriao.github.io/portfolio/>

## Legacy manual deploy

The `make deploy` target is still available if you want to push `public/`
to a separate deployment repository.

```console
$ git remote add deploy https://<yourrepourl>.git
$ make deploy
```

## Requirements

- pandoc >= 2.14
- python >= 3.7
