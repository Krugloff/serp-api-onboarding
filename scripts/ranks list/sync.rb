# API_KEY=1111... bundle exec ruby ./scripts/ranks\ list/sync.rb files/tracking.csv

require 'date'
require_relative "../../src/serp_api/google/search"

api_key = ENV["API_KEY"]
path = ARGV[0]
required_uri = "https://serpapi.com/"
date = Date.today.to_s

# I reduced the number of rows.
File.readlines(path)[2..200].each do |line|
  query, location = line.split(?,)[0..1]

  position = SerpApi::Google::Search
    .new(query, api_key:, location:, num: 100)
    .organic_results
    .index { _1.link.include?(required_uri) }

  position = position ? position.next : "100+"

  puts "#{query}, #{location}, #{date}, #{position}"
end