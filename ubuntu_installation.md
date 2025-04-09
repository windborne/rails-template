# Ubuntu installation

How to install various things on ubuntu

## Ruby
```shell
# Install dependencies
sudo apt update
sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libjemalloc2

# Install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
type -q bash && source ~/.bashrc

# Create Fish config directory if it doesn't exist
mkdir -p ~/.config/fish

# Create or append to config.fish
grep -q 'set -gx PATH $HOME/.rbenv/bin $PATH' ~/.config/fish/config.fish || \
echo 'set -gx PATH $HOME/.rbenv/bin $PATH' >> ~/.config/fish/config.fish

grep -q 'status --is-interactive; and source (rbenv init -|psub)' ~/.config/fish/config.fish || \
echo 'status --is-interactive; and source (rbenv init -|psub)' >> ~/.config/fish/config.fish

# Source the config file in current shell (if you're already using Fish)
type -q fish && source ~/.config/fish/config.fish

# Install ruby-build plugin
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install Ruby 3.2.2 and set it as global
rbenv install 3.2.2
rbenv global 3.2.2

# Install bundler and rails
gem install bundler
gem install rails

##############################
# INSTALL OTHER DEPENDENCIES #
##############################

sudo apt-get install --no-install-recommends -y \
    libvips \
    postgresql-client \
    python3 \
    python3-pip \
    python3-dev \
    python3-grib \
    build-essential git pkg-config libclang-dev clang libpq-dev

bundle install

echo "Installation complete!"

```

## Postgres

```shell
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install -y postgresql-16 libpq-dev
```

Edit /etc/postgresql/16/main/pg_hba.conf and change the authentication method from scram-sha to trust:
```
# IPv4 local connections:
host    all             all             127.0.0.1/32            trust
# IPv6 local connections:
host    all             all             ::1/128                 trut
```

Restart postgres
```shell
sudo systemctl restart postgresql
```

You may also need to configure the user and the template. Run `sudo -u postgres psql`, then:
```psql
CREATE ROLE windborne WITH LOGIN CREATEDB; 
UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
DROP DATABASE template1;
CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8';
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
\c template1
VACUUM FREEZE;
\q
```

## Node
```shell
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```

## Anycable
```shell
wget https://github.com/anycable/anycable-go/releases/download/v1.4.6/anycable-go-linux-amd64
chmod +x anycable-go-linux-amd64
sudo mv anycable-go-linux-amd64 /usr/local/bin/anycable-go
```

## Redis
```shell
sudo add-apt-repository ppa:redislabs/redis
sudo apt install software-properties-common
sudo add-apt-repository ppa:redislabs/redis
sudo apt update
sudo apt install redis-server
```

## Rust
```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
```


## Notes from John on installing rails on ubuntu:
this might not be good advice
+ `sudo apt-get install libyaml-dev libsqlite3-dev pkg-config npm rbenv` <- you might all or some of these
+ MAKE SURE TO ADD STUFF TO BASHRC AND THEN SOURCE IT!
+ make sure `which ruby` and `which rails` show an rbenv path.
+ `gem install rails`
+ exit bash and restart it
+ Okay now you can install the download the template
+ go to the directory and `bundle install` and then also `rail shakapacker:install` and `npm install mini-css-extract-plugin`
+ If you have more issues tbh Claude 3.7 is pretty helpful
