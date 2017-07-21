class ShortenedUrlsController < ApplicationController
  before_action :check_logged_user
  layout 'shortened_url'
  
  def index
      x = ShortenedUrlPolicy
      @shortened_urls = ShortenedUrl.where(user_id: current_user.id).order(:short_uri)
  end

  def show
      @shortened_url = ShortenedUrl.find(params[:id])
      authorize @shortened_url
  end

  def new
      @shortened_url = ShortenedUrl.new
  end

  def edit
      @shortened_url = ShortenedUrl.find(params[:id])
      authorize @shortened_url
  end

  def create
      @shortened_url = ShortenedUrl.new(shortened_url_params)
      @shortened_url.user_id = current_user.id

      if @shortened_url.save
          redirect_to shortened_urls_path
      else
          render 'new'
      end
  end

  def update
      @shortened_url = ShortenedUrl.find(params[:id])
      authorize @shortened_url

      if @shortened_url.update(shortened_url_params)
          redirect_to @shortened_url
      else
          render 'edit'
      end
  end

  def destroy
    @shortened_url = ShortenedUrl.find(params[:id])
    authorize @shortened_url
    
    @shortened_url.destroy

    redirect_to shortened_urls_path
  end

  private
  
  def shortened_url_params
      params.require(:shortened_url).permit(:destination_url, :short_uri)
  end

  def load_shortened_url
    ShortenedUrl.find(id: params[:id], user_id: current_user.id)
  end
end
