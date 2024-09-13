# API_KEY=1111... THREADS=200 bundle exec ruby ./scripts/ranks\ list/fibered.rb files/tracking.csv

require 'date'
require 'fiber_scheduler'
require_relative "../../src/serp_api/google/search"

api_key = ENV["API_KEY"]
path = ARGV[0]
threads_count = ENV["THREADS"].to_i
required_uri = "https://serpapi.com/"
date = Date.today.to_s

# I reduced the number of rows.
# Note: It will output the result in an unsorted order.
lines = File.readlines(path)[2..200]
chunks = lines.each_slice(lines.size/threads_count)

FiberScheduler do
  chunks.each do |chunk|
    Fiber.schedule do
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
end