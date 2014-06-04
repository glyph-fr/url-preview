module UrlPreview
  module Parsers
    class MetaTags
      attr_accessor :document, :resource, :og

      def process document, resource, url
        @document = document
        @resource = resource

        resource.source_url = url

        %w(title images description).each do |method|
          unless resource.present?(method)
            send("parse_#{ method }")
          end
        end
      end

      def parse_title
        if (tag = document.at_css("title"))
          resource.assign(title: tag.content)
        end
      end

      def parse_images
        # Find all items with a src attribute containing ".jpg"
        document.xpath("//*[contains(@src, '.jpg')]").each do |tag|
          # Check if the attribute ends with .jpg
          if (src = tag['src']).match(/\.(jpg)$/)
            resource.add_image(src)
          end
          # Only take 10 images max
          break if resource.images.length == 10
        end
      end

      def parse_description
        if (tag = document.at_xpath("//meta[@name='description']")) && (description = tag['content'])
          resource.assign(description: description)
        end
      end
    end
  end
end
