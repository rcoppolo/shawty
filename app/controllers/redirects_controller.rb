class RedirectsController < ApplicationController
  def index
    @referers = Referer.where(:url_id => params[:url_id])
  end
   
  def create
    
  end
end
