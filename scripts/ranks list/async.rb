# API_KEY=1111... bundle exec ruby ./scripts/ranks\ list/async.rb files/tracking.csv

# Improve performance of the serpapi.com ranks script by using async=true API parameter. async=true allows you to submit the full batch of requests first then get the actual results using their search_id and our search archive endpoint. (Ref: https://serpapi.com/search-archive-api)

require 'date'
require_relative "../../src/serp_api/google/search"
require_relative "../../src/serp_api/archive"

api_key = ENV["API_KEY"]
path = ARGV[0]
required_uri = "https://serpapi.com/"
date = Date.today.to_s

# I reduced the number of rows.
requests = File.readlines(path)[2..200].map do |line|
  query, location = line.split(?,)[0..1]

  id = SerpApi::Google::Search
    .new(query, api_key:, location:, num: 100, async: true)
    .search_metadata
    .id

  {id:, query:, location:}
end

requests.each do |request|
  # TODO: I should have added a delay between attempts for better control.
  success_search = Enumerator
    .produce { SerpApi::Archive.new(request[:id], api_key:) }
    .lazy
    .take(5)
    .find(&:success?)

  position = success_search.organic_results.index { _1.link.include?(required_uri) }

  position = position ? position.next : "100+"

  puts "#{request[:query]}, #{request[:location]}, #{date}, #{position}"
end