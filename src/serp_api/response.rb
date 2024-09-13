require 'oj'
require 'uri'
require 'net/http'

module SerpApi
  class Response
    DEFAULT_URI = "https://serpapi.com/search.json".freeze
    RETRIES_COUNT = 3

    private attr_reader :params, :uri

    def initialize(params = {}, uri: DEFAULT_URI)
      @params = params
      @uri = uri
    end

    def to_h
      Oj.load(body)
    end

    private

      def body
        @body ||= lazy_requests.find { _1.length > 0 }
      end

      def lazy_requests
        RETRIES_COUNT.times.lazy.map do
          Net::HTTP.get(URI("#{uri}/?#{query}"))
        rescue
          puts "ConnectionError! #{$!.class} #{params}"
          ""
        end
      end

      def query = URI.encode_www_form(params)
  end
end
