require_relative "../response"

module SerpApi
  module Bing
    class Search
      private attr_reader :query, :api_key

      def initialize(query, api_key:)
        @query = query
        @api_key = api_key
      end

      def organic_results
        body["organic_results"].map { Data.define(:link)[**_1.slice("link")] }
      end

      def answer_box = Data.define(:result)[**body["answer_box"].slice("result")]

      private

        def body
          @body ||= SerpApi::Response.new(params).to_h
        end

        def params = { q: query.to_s, api_key:, engine: "bing" }
    end
  end
end
