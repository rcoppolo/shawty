class Url < ActiveRecord::Base
  belongs_to :user
  has_many :referers, :dependent => :destroy
  
  validate :user_id, presence: true
  validate :long_url, presence: true, :length => { :minimum => 1 }
  validates_format_of :long_url,
                      with: /^[\S]+$/,
                      message: "Urls don't have spaces!"
                      
  validate :short_url, uniqueness: true
  
  after_create :generate_short_url  
    
  def generate_short_url 
    short_url = ''
    characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    characters = characters.split(//).shuffle.join
    base = characters.length
    num_to_tokenize = id
    while num_to_tokenize > 0 
      short_url = characters[(num_to_tokenize % base),1] + short_url
      num_to_tokenize = (num_to_tokenize / base)
    end
    self.update_attributes(:short_url => short_url)
  end
end
