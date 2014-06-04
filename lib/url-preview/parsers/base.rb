module UrlPreview
  module Parsers
    class Base
      attr_accessor :source, :url, :resource

      def initialize source, url, resource
        @source = source
        @url = url
        @resource = resource
      end
    end
  end
end
