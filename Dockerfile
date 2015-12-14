FROM ruby:2.2

ENV RAILS_ENV production

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
VOLUME /usr/src/app/log

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install --system --without development test && rm /usr/local/lib/ruby/gems/2.2.0/cache/*.gem && rm /usr/local/bundle/cache/*.gem

COPY . /usr/src/app
RUN bundle exec rake assets:precompile

CMD bundle exec magellan-rails
