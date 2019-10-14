require 'twitter'

require_relative 'phrase'

client = Twitter::REST::Client.new do |config|
	config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

def data_path(phrase_type)
    File.join("data", "#{phrase_type}.yaml")
end

def generate_tweet
    p = Phrase.new()
    p.newline = "\n"
	p.generate(data_path("bjork"))
end

tweet_text = generate_tweet()
client.update(tweet_text)
