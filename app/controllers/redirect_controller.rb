class RedirectController < ApplicationController
  def index
    # fullpath starts with /, :short_uri doesn't
    @url = ShortenedUrl.find_by(:short_uri => request.fullpath[1..-1])

    if @url
      if @url.is_locked || @url.show_preview_page
        # :formats prevents an error if path ends with some extension (like .zip)
        render 'redirect/preview', :formats => 'html'
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