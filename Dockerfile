FROM ruby:2.4-alpine
MAINTAINER Marcin Marcinkowski

# Directory for application
ENV APP_HOME /bitmap-editor

WORKDIR $APP_HOME
COPY . $APP_HOME

RUN bundle install

CMD ruby $APP_HOME/runner.rb