require 'nokogiri'
require 'curb'
require 'uri'

require 'url-preview/resource'
require 'url-preview/parsers/open_graph'
require 'url-preview/parsers/meta_tags'
require 'url-preview/parsers/base'
require 'url-preview/parsers/html'
require 'url-preview/parsers/image'

module UrlPreview
  class Parser
    attr_accessor :url, :response, :source

    def process url
      @url = URI.encode((url || "").strip)
      @response = Curl::Easy.perform(url) { |c| c.follow_location = true }
      # Return nil when page errored
      return resource unless response.response_code < 400

      @source = response.body_str

      parser = parser_for(@response).new(source, url, resource)
      parser.process
      parser.resource
    end

    private

    def parser_for(response)
      case response.content_type
      when /text\/html/
        UrlPreview::Parsers::HTML
      when /image\/\w+/
        UrlPreview::Parsers::Image
      end
    end

    def resource
      @resource ||= UrlPreview::Resource.new
    end
  end
end
