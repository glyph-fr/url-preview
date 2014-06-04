module UrlPreview
  module Parsers
    class Image < UrlPreview::Parsers::Base
      def process
        resource.assign(
          title: File.basename(url), images: [url], type: "image",
          source_url: url
        )
      end
    end
  end
end
