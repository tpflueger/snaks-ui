# snaks-ui

UI component of the [snaks](https://github.com/tpflueger/snaks) project. `snaks-ui` is currently a standalone snakes clone written in Elm, but the logic for the game will eventually be moved to [snaks-api](https://github.com/tpflueger/snaks-api) when multiplayer functionality is implemented.

## To Run

### With Docker (recommended)

* Build docker service `docker-compose build`
* Run docker service `docker-compose up`
* Load the application [in your browser](http://localhost:8080)

### Without Docker

* Install npm dependencies `npm install`
* Install Elm dependencies `elm-package install -y`
* Start webpack-dev-server `npm run dev`
* Load the application [in the browser](http://0.0.0.0:8080)
