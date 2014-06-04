module UrlPreview
  module Parsers
    class OpenGraph
      attr_accessor :document

      def process document, resource, url
        @document = document
        resource.source_url = url
        resource.assign(tags)
      end

      def tags
        @tags ||= document.xpath(query).reduce({}) do |hash, tag|
          data = attributes_mapping(tag["property"], tag["content"])
          hash.store(*data)
          hash
        end
      end

      def query
        '//meta[starts-with(@property, "og:")]'
      end

      def attributes_mapping name, value
        name.gsub!(/^og:/, "")
        if name == "image"
          ["images", [value]]
        else
          [name, value]
        end
      end
    end
  end
end
