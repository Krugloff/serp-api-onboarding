# API_KEY=1234... bundle exec ruby ./scripts/misspelling/api.rb "Richard Feinman"

# Make a script that suggests a spelling fix to any word misspelled using Google "did you mean?" results through our API

require_relative "../../src/serp_api/google/search"

api_key = ENV["API_KEY"]
query = ARGV[0]

suggestion = SerpApi::Google::Search.new(query, api_key: api_key).search_information.spelling_fix
puts suggestion ? "Did you mean? #{suggestion}" : "There are no misspellings detected"