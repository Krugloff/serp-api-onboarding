require_relative "../response"

module SerpApi
  module Google
    class Map
      private attr_reader :query, :api_key

      def initialize(query, api_key:)
        @query = query
        @api_key = api_key
      end

      def place_results
        related_data = body["place_results"].slice(*%w[rating reviews hours])
        Data.define(:rating, :reviews, :hours)[**related_data]
      end

      private

        def body
          @body ||= SerpApi::Response.new(params).to_h
        end

        def params = { q: query, api_key:, engine: "google_maps", hl: "en" }
    end
  end
end
