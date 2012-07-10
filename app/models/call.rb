class Call < ActiveRecord::Base
  belongs_to :course
  
  def self.call(course)
    
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