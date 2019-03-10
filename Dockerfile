FROM ruby:2.5.1

RUN apt-get update && apt-get install -y net-tools build-essential

# Install gems
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install

# Upload source
ADD . $APP_HOME

# Start server
ENV RACK_ENV "development"
ENV PORT 3000
EXPOSE 3000/tcp
CMD ["ruby", "webapp.rb"]
