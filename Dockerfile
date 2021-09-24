FROM ruby:2.7.1

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
  apt-get install -y build-essential \
  nodejs

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs

# chromedriverのインストール
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` \
  && wget -N http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip -P ~/ \
  && unzip ~/chromedriver_linux64.zip -d ~/ \
  && rm ~/chromedriver_linux64.zip \
  && chown root:root ~/chromedriver \
  && chmod 755 ~/chromedriver \
  && mv ~/chromedriver /usr/bin/chromedriver \
  && sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  google-chrome-stable \
  libpq-dev \
  nodejs \
  yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# capybara-webkitのインストール
RUN apt-get update && apt-get install -y \
                      qt5-default \
                      libqt5webkit5-dev \
                      gstreamer1.0-plugins-base \
                      gstreamer1.0-tools\
                      gstreamer1.0-x
                      
# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /onayami_app
WORKDIR /onayami_app

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /onayami_app/Gemfile
ADD Gemfile.lock /onayami_app/Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /onayami_app

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
