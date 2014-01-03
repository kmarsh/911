#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'twitter'
require 'csv'

TWITTER = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
end

# from https://github.com/sferik/twitter/blob/master/examples/AllTweets.md
def collect_with_max_id(collection = [], max_id = nil, &block)
  response = yield max_id
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

def get_all_tweets(user, filename)
  collect_with_max_id do |max_id|
    options = {count: 200, include_rts: false}
    options[:max_id] = max_id unless max_id.nil?
    f = TWITTER.user_timeline(user, options)

    CSV.open(filename, "a+") do |csv|
      f.each do |tweet|
        csv << [tweet.id, tweet.created_at, tweet.full_text]
      end
    end

    f
  end
end

get_all_tweets(ARGV[0], ARGV[1])
