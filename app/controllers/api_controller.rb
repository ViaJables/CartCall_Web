class ApiController < ApplicationController
  def get_course
    latitude = params[:latitude]
    longitude = params[:longitude]
    c = Course.near([latitude, longitude], 1)
    if c.nil?
      render :json => {:status => 'invalid_location'}
    else
      render :json => {:status => 'success', :result => c.as_json}
    end
  end
  
  def call_cart
    #params
    c = params[:course_id]
    latitude = params[:latitude]
    longitude = params[:longitude]
    identifier = params[:identifier]
    
    #check for values
    if c.blank? ? return : course = Course.find(v) #set course
    if latitude.blank? || longitude.blank? || identifier.blank? ? return : true
    
    #summon the cart
    call = course.call_cart(latitude, longitude, identifier)
    
    if call
      render :json => {:status => 'error'}
    else
      render :json => {:status => 'success'}
    end
  end
  
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
