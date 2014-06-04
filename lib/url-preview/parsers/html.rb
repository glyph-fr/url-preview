module UrlPreview
  module Parsers
    class HTML < UrlPreview::Parsers::Base
      def process
        document = Nokogiri::HTML(source)

        parsers.each do |parser|
          parser.process(document, resource, url)
        end
      end

      private

      def parsers
        @parsers ||= [
          UrlPreview::Parsers::OpenGraph.new,
          UrlPreview::Parsers::MetaTags.new
        ]
      end
    end
  end
end
