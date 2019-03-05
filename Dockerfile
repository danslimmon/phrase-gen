FROM ruby:2.5.1

RUN apt-get update && apt-get install -y net-tools

# Install gems
ENV APP_HOME /app
RUN mkdir $APP_HOME
RUN gem install sinatra

# Upload source
COPY . $APP_HOME

# Start server
ENV PHRASEGEN_PORT 3000
EXPOSE 3000/tcp
WORKDIR $APP_HOME
CMD ["ruby", "webapp.rb"]
