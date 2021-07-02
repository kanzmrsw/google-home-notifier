FROM node:lts

WORKDIR /app

RUN npm update -y -g npm \
    && apt update \
    && apt install -y avahi-daemon libavahi-compat-libdnssd-dev libnss-mdns

COPY package*.json ./
RUN npm install

COPY browser.js node_modules/mdns/lib/browser.js

COPY . .

CMD service dbus start && service avahi-daemon start && node example.js
