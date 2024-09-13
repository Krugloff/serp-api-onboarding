# API_KEY=1111... THREADS=100 bundle exec ruby ./scripts/ranks\ list/threaded.rb files/tracking.csv

# Improve performance of the serpapi.com ranks script by using your language threads using the regular async=false flow. Parallelize search submissions to SerpApi with a couple of threads.

require 'date'
require_relative "../../src/serp_api/google/search"

api_key = ENV["API_KEY"]
threads_count = ENV["THREADS"].to_i
path = ARGV[0]
required_uri = "https://serpapi.com/"
date = Date.today.to_s

# I reduced the number of rows.
lines = File.readlines(path)[2..200]

threads = lines.each_slice(lines.size/threads_count).map do |chunk|
  Thread.new do
    chunk.each do |line|
      query, location = line.split(?,)[0..1]

      position = SerpApi::Google::Search
        .new(query, api_key:, location:, num: 100)
        .organic_results
        .index { _1.link.include?(required_uri) }

      position = position ? position.next : "100+"

      puts "#{query}, #{location}, #{date}, #{position}"
    end
  end
end

threads.map(&:join)