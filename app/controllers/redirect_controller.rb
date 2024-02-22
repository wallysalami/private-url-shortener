class RedirectController < ApplicationController
  def index
    # fullpath starts with /, :short_uri doesn't
    @url = ShortenedUrl.where('LOWER(short_uri) = ?', request.fullpath[1..-1].downcase).first

    if @url
      if @url.is_locked || @url.show_preview_page
        # :formats prevents an error if path ends with some extension (like .zip)
        render 'preview', formats: [:html], handlers: [:erb]
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

  def page_title_for_url(shortened_url)
    shortened_url.title + ' | ' +  page_title
  end
  helper_method :page_title_for_url
end