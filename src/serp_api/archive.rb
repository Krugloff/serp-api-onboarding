require_relative "./response"

module SerpApi
  class Archive
    DEFAULT_URI = "https://serpapi.com/searches".freeze

    private attr_reader :search_id, :api_key

    def initialize(search_id, api_key:)
      @search_id = search_id
      @api_key = api_key
    end

    def success?
      body.dig("search_metadata", "status").eql?("Success")
    end

    def organic_results
      body["organic_results"].to_a.map { Data.define(:link)[**_1.slice("link")] }
    end

    private

      def body
        @body ||= SerpApi::Response.new(params.to_h, uri:).to_h
      end

      def uri = [DEFAULT_URI, "#{search_id}.json"].join(?/)
      def params = { api_key: }
  end
end