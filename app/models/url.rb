class Url < ActiveRecord::Base
  belongs_to :user
  has_many :referers, :dependent => :destroy
  
  validate :user_id, presence: true
  validate :long_url, presence: true, :length => { :minimum => 13 }
  validates_format_of :long_url,
                      with: /^[\S]+$/,
                      message: "Urls don't have spaces!"
                      
  validate :short_url, uniqueness: true
  
  after_create :generate_short_url  
    
  private  
  
  def generate_short_url
    self.update_attribute(:short_url, convert_long_url_to_base_62(id))
  end
  
  def convert_long_url_to_base_62 id
    short_url = ''
    characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    base = characters.length
    while id > 0 
      short_url = characters[(id % base),1] + short_url
      id = (id / base)
    end
    short_url
  end
  
end
