class ShortenedUrlsController < ApplicationController
  before_action :check_logged_user
  layout 'shortened_url'
  
  def index
      x = ShortenedUrlPolicy
      @shortened_urls = ShortenedUrl.where(user_id: current_user.id).order('LOWER(title)')
      @host = request.host
      @base_url = request.base_url
  end

  def show
      @shortened_url = ShortenedUrl.find(params[:id])
      authorize @shortened_url

      @grouped_accesses = ShortenedUrlAccess.group_by_date(@shortened_url.shortened_url_access)
      @base_url = request.host
  end

  def new
      @shortened_url = ShortenedUrl.new
      @host = request.host
  end

  def edit
      @shortened_url = ShortenedUrl.find(params[:id])
      authorize @shortened_url
      @host = request.host
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

  def page_title_for_admin(main_title)
    if main_title == ''
      page_title
    else
      main_title + ' | ' +  page_title
    end
  end
  helper_method :page_title_for_admin

  def page_title
    t(:my_urls) + ' | ' +  super
  end

  private
  
  def shortened_url_params
      params.require(:shortened_url).permit(:destination_url, :short_uri, :title, :description, :is_locked, :show_preview_page)
  end

  def load_shortened_url
    ShortenedUrl.find(id: params[:id], user_id: current_user.id)
  end
end
