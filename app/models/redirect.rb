class Redirect < ActiveRecord::Base
  belongs_to :url
  
  validates :url_id, :presence => true
end
