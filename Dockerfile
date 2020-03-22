FROM ruby:2.6
RUN mkdir /hsm
WORKDIR /hsm
COPY Gemfile /hsm/Gemfile
COPY Gemfile.lock /hsm/Gemfile.lock
RUN gem install bundler
RUN gem install rspec
RUN bundle install
COPY . /hsm
EXPOSE 4567/tcp
