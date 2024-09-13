# API_KEY=1234... bundle exec ruby ./scripts/google\ map/api.rb "Qaz-taktik, Astana"

# Make a script to get the open hours, rating, and number of reviews of a local business using our Google Maps API

require_relative "../../src/serp_api/google/map"

api_key = ENV["API_KEY"]
company = ARGV[0] # "Qaz-taktik, Astana"

puts SerpApi::Google::Map.new(company, api_key: api_key).place_results

# TODO: prettify result
#<data rating=4.8, reviews=68, hours=[{"thursday"=>"10 AM–7 PM"}, {"friday"=>"10 AM–7 PM"}, {"saturday"=>"10 AM–6 PM"}, {"sunday"=>"Closed"}, {"monday"=>"10 AM–7 PM"}, {"tuesday"=>"10 AM–7 PM"}, {"wednesday"=>"10 AM–7 PM"}]>