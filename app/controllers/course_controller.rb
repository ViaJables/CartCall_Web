class CourseController < ApplicationController
  
  def find_course
    latitude = params[:latitude]
    longitude = params[:longitude]
    c = Course.get_nearby_courses(latitude, longitude, 1)
    if c.nil?
      render :json => {:status => 'invalid_location'}
    else
      render :json => {:status => 'success', :result => c.as_json}
    end
  end
  
  def summon_cart
    #params
    c = params[:course_id]
    latitude = params[:latitude]
    longitude = params[:longitude]
    
    #check for values
    c.blank? ? return : course = Course.find(c) #set course
    latitude.blank? || longitude.blank? ? return false : true
    
    #summon the cart
    call = course.notify_carts(latitude, longitude)
    
    if call
      render :json => {:status => 'error'}
    else
      render :json => {:status => 'success', :result => call.as_json}
    end
  end
  
end