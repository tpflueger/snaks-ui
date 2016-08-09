FROM codesimple/elm:0.17

RUN apt-get update
RUN apt-get install -y nodejs npm nodejs-legacy git

COPY package.json /opt/
COPY elm-package.json /opt/

RUN npm install
RUN elm package install -y

COPY webpack.config.js /opt/

EXPOSE 8080
ENTRYPOINT ["npm", "run", "dev"]