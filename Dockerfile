FROM ruby:2.5.7

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       vim

RUN mkdir /FashionInformation_app

WORKDIR /FashionInformation_app

ADD Gemfile /FashionInformation_app/Gemfile
ADD Gemfile.lock /FashionInformation_app/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /FashionInformation_app

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids
