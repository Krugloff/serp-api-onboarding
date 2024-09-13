# API_KEY=1234... bundle exec ruby ./scripts/birthday/old_lib.rb "Richard Feynman"

require 'google_search_results'

api_key = ENV["API_KEY"]
fullname = ARGV[0] # "Richard Feynman"

query = "#{fullname} date of birth"

puts GoogleSearch.new(q: query, serp_api_key: api_key, no_cache: true).get_hash.dig(:answer_box, :answer)
puts BingSearch.new(q: query, serp_api_key: api_key, no_cache: true).get_hash.dig(:answer_box, :result)
puts DuckduckgoSearch.new(q: query, serp_api_key: api_key, no_cache: true).get_hash.dig(:knowledge_graph, :facts, :born)
puts YahooSearch.new(p: query, serp_api_key: api_key, no_cache: true).get_hash.dig(:knowledge_graph, :born)

# 11 Mayıs 1918
# May 11, 1918
# Richard Phillips Feynman, May 11, 1918, New York City, U.S.
# May 11, 1918, New York City, U.S.