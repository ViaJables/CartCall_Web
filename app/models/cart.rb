class Cart < ActiveRecord::Base
  belongs_to :course
  has_many :summons
  
  attr_accessible :latitude, :longitude, :name, :course
  
  def self.update_position(lat, long, s, c)
    if s.cart_id == c.id
      Pusher["#{s.id}_summon_feed"].trigger('cart_location', :cart => {:latitude => lat, :longitude => long}.as_json)
    end
  end
  
end