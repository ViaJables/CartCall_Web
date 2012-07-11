class Call < ActiveRecord::Base
  belongs_to :course
  
  #attributes
  attr_accessible :latitude, :longitude, :served, :on_my_way, :course
  #validators
  validates_presence_of :latitude, :longitude, :course
  
  def self.notify(course, lat, long)
    # Create Unique Token for Golfer (just the id of the call for now), Save & Return
    return Call.create(:course => course, :latitude => lat, :longitude => long)
  end
  
  def start(lat, long)
    self.update_attributes(:latitude => lat, :longitude => long)
  end
  
  def update(lat, long)
    self.update_attributes(:latitude => lat, :longitude => long)
  end
  
  def complete
    self.update_attributes(:served => true)
  end
  
  def send_cart_location
    
  end
  
end