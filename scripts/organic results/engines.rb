# API_KEY=1234... bundle exec ruby ./scripts/organic\ results/api.rb "serpapi"

# Make a script that get "serpapi" result urls with our Google Organic Search API, Yahoo API, Baidu API, and Bing API

require_relative "../../src/serp_api/google/search"
require_relative "../../src/serp_api/bing/search"
require_relative "../../src/serp_api/baidu/search"
require_relative "../../src/serp_api/yahoo/search"

api_key = ENV["API_KEY"]
query = ARGV[0] # "serapi"

%w[Google Yahoo Baidu Bing].each do
  puts [_1, SerpApi.const_get(_1)::Search.new(query, api_key:).organic_results.first.link].join(":")
end