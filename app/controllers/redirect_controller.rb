class RedirectController < ApplicationController
  def index
    @url = ShortenedUrl.find_by(:short_uri => params[:short_uri])
    if @url
      redirect_to @url.destination_url
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end