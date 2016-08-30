FROM codesimple/elm:0.17

RUN apt-get update
RUN apt-get install -y nodejs npm nodejs-legacy git

COPY package.json /opt/
RUN npm install

COPY elm-package.json /opt/
RUN elm package install -y

COPY webpack.config.js /opt/
COPY ./src /opt/src/

EXPOSE 8080
ENTRYPOINT ["npm", "run", "dev"]
