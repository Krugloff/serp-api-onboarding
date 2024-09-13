require_relative "../response"

module KruglovApi
  module Google
    class Birthday
      DEFAULT_URI = "https://www.google.com/search"

      # Note: This is working for "Taylor Swift" and "Richard Feynman"
      # This is not working for "Donald Trump" or "Imran Khan"
      # The HTML files are located within the "files/" directory.
      ELEMENT_SELECTOR = %q{#main img[style="max-width:100%;max-height:90px"]}.freeze

      NoInfoError = Class.new(StandardError)

      private attr_reader :fullname

      def initialize(fullname)
        @fullname = fullname
      end

      def to_s = image["alt"]

      private

        def image = tree.at_css(ELEMENT_SELECTOR) || raise(NoInfoError)
        def tree = response.tree

        # TODO: For some reason, the results don't include rich elements like the knowledge graph.
        # I need to investigate this further.
        def response = KruglovApi::Response.new(DEFAULT_URI, params)
        # english by default
        # US results by default
        def params = { q: query.to_s, hl: "en", gl: "us" }
        def query = "#{fullname} date of birth"
    end
  end
end