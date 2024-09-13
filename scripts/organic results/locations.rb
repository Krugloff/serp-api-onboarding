# API_KEY=1234... bundle exec ruby ./scripts/organic\ results/locations.rb "serpapi"

# Make a script that get "serpapi" result urls for 10 locations on our Google Organic Search API

require_relative "../../src/serp_api/google/search"

api_key = ENV["API_KEY"]
query = ARGV[0] # "serapi"

countries = %w[us ca ru kz cn ua rs tr pk br]

countries.each do |country|
  first_link = SerpApi::Google::Search.new(query, api_key:, country:).organic_results.first.link
  puts [country, first_link].join(?:)
end