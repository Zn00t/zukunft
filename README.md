# README

## setup the system

### ruby

install rvm via rvm.io

* rvm pkg install openssl
* rvm reinstall ruby-3 --with-openssl-dir=/usr/local/rvm/usr

### node

node needs to be v16 otherwise webpack will implode

* add nodesource to apt
```deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main
```
* apt update
* apt install nodejs


## setup
* bundle

* b rake yarn:install

* setup db `b rake db:migrate`

* seed db `b rake db:seed`

* yarn

* have webpacker running `./bin/webpack-dev-server`
