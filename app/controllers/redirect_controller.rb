class RedirectController < ApplicationController
  def index
    @url = ShortenedUrl.find_by(:short_uri => params[:short_uri])
    redirect_to @url.destination_url
  end
end