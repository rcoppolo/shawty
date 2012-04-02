class UrlsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :destroy, :edit]
  
  def index
     @urls = Url.find_all_by_user_id(current_user.id)
  end
  
  def new
    @url = Url.new#current_or_guest_user.urls.build
  end
  
  def show
    url = Url.find_by_short_url params[:short_url]
    url.referers.build(:url_id => url.id, :http_referer => request.env['HTTP_REFERER'] )
    url.click_counter += 1
    url.save
    redirect_to url.long_url
  end
  
  def edit
    session[:return_to] ||= request.referer
    @url = Url.find(params[:id])
  end

  def create
    @url = Url.new(params[:url])
    @url.user_id = current_or_guest_user.id
    @url.click_counter = 0

    respond_to do |format|
      if @url.save
        flash.now[:success] = " Here's your new URL: " + "http://#{request.host_with_port}/" + @url.short_url
        format.js
        format.html
      else
        flash.now[:error] = "Error shortening that URL! Make sure it's in the format of http:// of https://"
        format.js
      end
    end
  end
  
  def update
    @url = Url.find params[:id]
    if @url.update_attributes(params[:url])
      flash[:success] = " URL saved."
      redirect_to session[:return_to] 
    else
      flash[:error] = "Really? Its one field"
      redirect_to 'http://failblog.org'
    end
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
