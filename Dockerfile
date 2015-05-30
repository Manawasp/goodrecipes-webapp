FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential nodejs npm nodejs-legacy mysql-client vim
RUN npm install -g phantomjs

RUN mkdir /myapp

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY bower.json bower.json
RUN bundle install
RUN npm install bower -g

ADD . /myapp
WORKDIR /myapp
COPY bower.json bower.json
RUN bower --allow-root install
RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
CMD ["rails","server","-b","0.0.0.0"]
