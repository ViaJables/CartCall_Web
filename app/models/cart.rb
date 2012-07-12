class Cart < ActiveRecord::Base
  belongs_to :course
  
  def get_location
    
  end
  
  def check_for_active_carts(course)
    
  end
  
end