FROM ruby:2.7.4-buster
LABEL authors="Vinicius Bispo <vini@sopha.com.br>"

ENV APP_HOME /rails-docker

RUN apt-get update -qq
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb
RUN apt-get -y install xfonts-75dpi xfonts-base
RUN apt-get --fix-broken install
RUN dpkg -i wkhtmltox_0.12.6-1.buster_amd64.deb
RUN apt-get --fix-broken install
RUN apt-get install -y \
    build-essential \
    git \
    ghostscript \
    imagemagick \
    libcurl4 \
    libmagickwand-dev \
    libpq-dev \
    libsodium-dev \
    nodejs \
    shared-mime-info \
    && apt-get autoclean \ && apt-get autoremove -y

RUN gem install puma -v '3.12.6'

RUN gem install bundler -v 1.17.3

RUN mkdir $APP_HOME

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
ADD vendor/knock $APP_HOME/vendor/knock

RUN bundle check || bundle install
ADD . $APP_HOME

CMD RAILS_ENV=${RAILS_ENV} bundle exec rake db:create db:migrate && bundle exec rails s -p ${PORT} -b '0.0.0.0'
