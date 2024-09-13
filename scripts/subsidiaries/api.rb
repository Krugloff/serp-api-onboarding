# API_KEY=1234... bundle exec ruby ./scripts/subsidiaries/api.rb "samsung"

# Make a script to fetch the list of subsidiaries (carousel view like "apple subsidiaries") of any company in the world using our API

require_relative "../../src/serp_api/google/search"

api_key = ENV["API_KEY"]
company = ARGV[0] # "samsung"

query = "#{company} subsidiaries"

puts SerpApi::Google::Search
  .new(query, api_key: api_key)
  .knowledge_graph["subsidiaries"]
  .map { _1["name"] }