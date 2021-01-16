ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

ARG NODE_MAJOR
ARG YARN_VERSION

# ログインシェルとしてbashを使用する
SHELL ["/bin/bash", "-c"]

# nodejs取得
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# yarn取得
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq &&\
  apt-get install -y\
  build-essential\
  nodejs\
  yarn=$YARN_VERSION-1

# chromeの追加
RUN apt-get update && apt-get install -y unzip && \
    CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/ && \
    unzip ~/chromedriver_linux64.zip -d ~/ && \
    rm ~/chromedriver_linux64.zip && \
    chown root:root ~/chromedriver && \
    chmod 755 ~/chromedriver && \
    mv ~/chromedriver /usr/bin/chromedriver && \
    sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y google-chrome-stable

# ルート直下にself-management-appという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /self-management-app
WORKDIR /self-management-app

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /self-management-app/Gemfile
ADD Gemfile.lock /self-management-app/Gemfile.lock

# bundle installの実行
RUN gem install bundler:2.0.2
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /self-management-app

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets

# コンテナ開始時に必ず実行されるシェルスクリプトをコンテナにコピー
ADD entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]