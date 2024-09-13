# bundle exec ruby ./scripts/birthday/raw.rb "Richard Feinman"

require_relative "../../src/kruglov_api/google/birthday"

fullname = ARGV[0] # "Richard Feynman"
puts KruglovApi::Google::Birthday.new(fullname).to_s