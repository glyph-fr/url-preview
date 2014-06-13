module UrlPreview
  class Resource
    attr_accessor :title, :description, :type, :source_url
    attr_writer :images

    def data
      @data ||= {}
    end

    def assign hash
      hash.each do |name, value|
        name = name.to_s

        if attributes.include?(name)
          send(:"#{ name }=", value) unless present?(name)
        else
          data.store(name, value) unless data[name]
        end
      end
    end

    def images
      @images ||= []
    end

    def add_image path
      path = URI.parse(URI.encode((path || "").strip))
      images << URI.join(source_url, path).to_s
    end

    def valid?
      !!source_url
    end

    def present? attribute
      value = public_send(attribute)
      value.respond_to?(:empty?) ? !value.empty? : value
    end

    def attributes
      @attributes ||= %w(title description images type data source_url)
    end

    def as_json(options = nil)
      attributes.reduce({}) do |hash, name|
        hash.store(name, send(name))
        hash
      end
    end
  end
end
