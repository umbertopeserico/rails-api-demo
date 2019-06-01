FROM ruby:2.6-stretch

# Install required dependencies
RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client-10

# Set workdir
RUN mkdir /app
WORKDIR /app

# Install basic gems
RUN gem install rails:'~> 5.2.3' nokogiri ffi

# Copy Gemfile
COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock
RUN bundle install
COPY . .

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
