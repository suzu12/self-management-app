FROM ruby:2.6

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

RUN mkdir /self-management-app
WORKDIR /self-management-app

ADD Gemfile /self-management-app/Gemfile
ADD Gemfile.lock /self-management-app/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /self-management-app

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids