# API_KEY=1234... bundle exec ruby ./scripts/birthday/api.rb "Richard Feynman"

require_relative "../../src/serp_api/google/search"

require_relative "../../src/serp_api/bing/search"
require_relative "../../src/serp_api/duckduckgo/search"
require_relative "../../src/serp_api/yahoo/search"

api_key = ENV["API_KEY"]
fullname = ARGV[0] # "Richard Feynman"

query = "#{fullname} date of birth"

puts SerpApi::Google::Search.new(query, api_key: api_key).answer_box.answer
puts SerpApi::Bing::Search.new(query, api_key: api_key).answer_box.result
puts SerpApi::Duckduckgo::Search.new(query, api_key: api_key).knowledge_graph.facts["born"]
puts SerpApi::Yahoo::Search.new(query, api_key: api_key).knowledge_graph["born"]

# 11 Mayıs 1918
# May 11, 1918
# Richard Phillips Feynman, May 11, 1918, New York City, U.S.
# May 11, 1918, New York City, U.S.