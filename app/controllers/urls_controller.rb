class UrlsController < ApplicationController
  before_filter :signed_in?, :only => :index
  
  def index
     @urls = Url.find_all_by_user_id(current_user.id)
  end
  
  def new
    @url = Url.new
  end
  
  def show
    
  end
  
  def edit
    session[:return_to] ||= request.referer
    @url = Url.find(params[:id])
  end

  def create
    @url = Url.new(params[:url])
    @url.click_counter = 0
 
    unless @url.long_url.include?('http://')
      p "HI"
        @url.update_attribute(:long_url, "http://" + @url.long_url)
        p @url.long_url
    end
    
    if @url.save
      flash[:success] = "SHORT URL GENERATED " + @url.short_url
      redirect_to root_url
    else
      flash[:error] = "Something went wrong!"
      render "new"
    end
  end
  
  def update
    @url = Url.find params[:id]
    if @url.update_attributes(params[:url])
      flash[:success] = "You've changed your URL"
      redirect_to session[:return_to] 
    else
      flash[:error] = "Damn son, its one field"
      redirect_to 'http://failblog.org'
    end
  end
  
  def redirector
    url = Url.find_by_short_url params[:short_url]
    url.referers.build(:url_id => url.id, :http_referer => request.env['HTTP_REFERER'] )
    url.click_counter += 1
    url.save
    logger.info { url }
    redirect_to url.long_url
  end
  
  def destroy
    @url = Url.find(params[:id])
    @url.destroy
    redirect_to urls_path
  end

  private
  
  def signed_in?
    true if user_signed_in?
  end

end
