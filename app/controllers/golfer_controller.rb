class GolferController < ApplicationController
  
    #### update your location to the cart ####
  def update_location
    c = params[:course_id]
    latitude = params[:latitude]
    longitude = params[:longitude]
    cid = params[:call_id]
    
    if c.blank? ? return : course = Course.find(v)
    if latitude.blank? || longitude.blank? || cid.blank? ? return : true
  end
  
end
