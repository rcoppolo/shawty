class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_or_guest_user
  
  def after_sign_in_path_for(resource)
    current_or_guest_user
    super
  end
  
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        assign_urls_to_user
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      return current_user
    else
      guest_user
    end
  end
  
  def guest_user
   session[:guest_user_id].nil? ? session[:guest_user_id] =  create_guest_user.id : session[:guest_user_id]
   User.find(session[:guest_user_id])
  end
  
  private
  
  def assign_urls_to_user
    urls = Url.find_all_by_user_id(session[:guest_user_id])
    urls.each { |url| url.user_id = current_user.id;url.save}
  end
  
  def create_guest_user
    user = User.create!(:email => "guest_#{Time.now.to_i}#{rand(99)}@email_address.com",
                        :password => Devise.friendly_token[0,20])
  end
end
