class Course < ActiveRecord::Base
  #associations
  has_many :calls
  has_many :carts
  
  #attributes
  attr_accessible :latitude, :longitude, :name
  #validators
  validates_presence_of :latitude, :longitude, :name
  
  def call_cart
    Call.call(self)
  end
  
  
end