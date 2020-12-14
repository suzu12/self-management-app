FROM ruby:2.6

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       vim

RUN mkdir /self-management-app

WORKDIR /self-management-app

ADD Gemfile /self-management-app/Gemfile
ADD Gemfile.lock /self-management-app/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /self-management-app

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids
CMD bundle exec puma