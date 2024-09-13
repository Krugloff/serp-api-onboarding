require_relative "../response"

module SerpApi
  module Baidu
    class Search
      private attr_reader :query, :api_key

      def initialize(query, api_key:)
        @query = query
        @api_key = api_key
      end

      def organic_results
        body["organic_results"].map { Data.define(:link)[**_1.slice("link")] }
      end

      private

        def body
          @body ||= SerpApi::Response.new(params).to_h
        end

        def params = { q: query.to_s, api_key:, engine: "baidu" }
    end
  end
end
