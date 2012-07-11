class Course < ActiveRecord::Base
  #associations
  has_many :calls
  has_many :carts
  
  #attributes
  attr_accessible :latitude, :longitude, :name, :pin
  #validators
  validates_presence_of :latitude, :longitude, :name, :pin
  
  reverse_geocoded_by :latitude, :longitude
  
  def notify_carts(lat, long)
    return Call.notify(self, lat, long)
  end
  
  def self.get_nearby_courses(lat, long, dist)
    return Course.near([lat, long], dist)
  end
  
end