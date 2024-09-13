# API_KEY=1234... bundle exec ruby ./scripts/birthday/new_lib.rb "Richard Feynman"

require 'serpapi'

api_key = ENV["API_KEY"]
fullname = ARGV[0] # "Richard Feynman"

query = "#{fullname} date of birth"

puts SerpApi::Client.new(api_key:).search(q: query, engine: "google").dig(:answer_box, :answer)
puts SerpApi::Client.new(api_key:).search(q: query, engine: "bing").dig(:answer_box, :result)
puts SerpApi::Client.new(api_key:).search(q: query, engine: "duckduckgo").dig(:knowledge_graph, :facts, :born)
puts SerpApi::Client.new(api_key:).search(p: query, engine: "yahoo").dig(:knowledge_graph, :born)

# May 11, 1918
# May 11, 1918
# Richard Phillips Feynman, May 11, 1918, New York City, U.S.
# May 11, 1918, New York City, U.S.