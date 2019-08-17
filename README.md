![ChatUI progess](https://chatwoot.com/images/dashboard-screen.png)

## Build Setup


### Install JS dependencies

``` bash
yarn install
```

### Install ImageMagik

```bash
brew install imagemagick
```

### Setup rails server

```bash
# install ruby dependencies
bundle

# copy database config
cp shared/config/database.yml config/database.yml

# copy frontend env file
cp .env.sample .env

# run db migrations
bundle exec rake db:migrate

# fireup the server
foreman start
```