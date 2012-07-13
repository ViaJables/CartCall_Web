class Summon < ActiveRecord::Base
  belongs_to :course
  has_one :cart
  
  #attributes
  attr_accessible :latitude, :longitude, :served, :on_my_way, :course, :cart_id, :cart
  #validators
  validates_presence_of :latitude, :longitude, :course
    
  def self.notify(course, lat, long)
    # Create Unique Token for Golfer (just the id of the call for now), Save & Return
    c = Summon.create(:course => course)
    c.update_position(lat, long)
    return c
  end
  
  def update_position(lat, long)
    self.update_attributes(:latitude => lat, :longitude => long)
  end
  
  def accept(cart)
    self.update_attributes(:on_my_way => Time.now, :cart_id => cart)
  end
  
  def serve
    self.update_attributes(:served => Time.now)
  end
  
  def send_cart_location
    
  end
  
end