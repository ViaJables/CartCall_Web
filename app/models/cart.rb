class Cart < ActiveRecord::Base
  belongs_to :course
  
  def self.update_position(lat, long, s)
    Pusher["#{s.id}_summon_feed"].trigger('cart_location', :cart => {:latitude => lat, :longitude => long}.as_json)
  end
  
  def check_for_active_carts(course)
    
  end
  
end