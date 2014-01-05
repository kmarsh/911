#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'twitter'

TWITTER = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
end

toledoscanner_user_id = "1063882496"
TWITTER.filter(:follow => toledoscanner_user_id) do |object|
  puts object.inspect if object.is_a?(Twitter::Tweet)
end
