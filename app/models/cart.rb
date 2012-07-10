class Cart < ActiveRecord::Base
  belongs_to :course
  
  def get_location
    
  end
end