class UrlsController < ApplicationController
  before_filter :signed_in?, :only => :index
  
  def index
     @urls = Url.find_all_by_user_id(current_user.id)
  end
  
  def show
    
  end
  
  def new
    @url = Url.new
  end
  
  def create
    @url = Url.new(params[:url])
    if @url.save
      flash[:success] = "URL added"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong"
      render "new"
    end
  end
  
  def redirector
    url = Url.find_by_short_url params[:short_url]
    logger.info { url }
    redirect_to url.long_url
  end
  
  def destroy
    @url = Url.find(params[:id])
    @url.destroy
    # redirect_to urls_path
  end

  private
  
  def signed_in?
    true if user_signed_in?
  end

end
