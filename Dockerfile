# cloudcc-api-api
# docker build -t sleeper-app .
# docker build -t sleeper-app:0.0.1 .
# docker tag sleeper-app:0.0.1 sleeper-app:latest
# docker run --rm -it sleeper-app bash

FROM ruby:2.4.2-jessie

MAINTAINER Andrii Ageiev <aageiev@determine.com>

RUN curl -sL https://deb.nodesource.com/setup_8.x -o /tmp/nodesource_setup8.sh \
    && chmod +x /tmp/nodesource_setup8.sh \
    && sh /tmp/nodesource_setup8.sh

RUN apt-get update -qq && apt-get install -y build-essential software-properties-common imagemagick libmysqlclient-dev nodejs
RUN \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Install Java.
#RUN \
#  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
#  add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" && \
#  apt-get update && \
#  apt-get install -y oracle-java8-installer && \
#  rm -rf /var/lib/apt/lists/* && \
#  rm -rf /var/cache/oracle-jdk8-installer

RUN mkdir /app
WORKDIR /app
COPY . /app/
RUN bundle install

EXPOSE 9292

CMD bundle exec puma -p 9292
