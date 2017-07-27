class RedirectController < ApplicationController
  def index
    @url = ShortenedUrl.find_by(:short_uri => params[:short_uri])
    if @url
      if @url.is_locked || @url.show_preview_page
        render 'preview'
      else
        redirect_to @url.destination_url
      end
      
      # since register_access looks for the IP data on the internet,
      # we open another thread to not wait and delay the current request
      Thread.new do
        ShortenedUrlAccess.register_access(request, @url)
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end