module UrlPreview
  class PreviewController < UrlPreview::ApplicationController
    def show
      resource = UrlPreview::Parser.new.process(params[:url])

      if resource.valid?
        render json: resource
      else
        render json: {}, status: 404
      end
    end
  end
end
