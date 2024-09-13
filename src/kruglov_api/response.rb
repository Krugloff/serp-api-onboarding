require 'net/http'
require 'uri'
require 'nokolexbor'

module KruglovApi
  class Response
    private attr_reader :uri, :params

    def initialize(uri, params = {})
      @uri = uri
      @params = params
    end

    def tree = Nokolexbor::HTML(html)

    private

      def html = Net::HTTP.get(URI("#{uri}?#{query}"))
      def query = URI.encode_www_form(params)
  end
end