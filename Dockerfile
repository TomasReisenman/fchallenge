FROM ruby:3.3.7 AS base

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bundle", "exec", "puma"]

FROM base AS test

CMD ["ruby", "test/test.rb"]