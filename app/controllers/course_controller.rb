class CourseController < ApplicationController
  
  def find_course
    latitude = params[:latitude]
    longitude = params[:longitude]
    c = Course.get_nearby_courses(latitude, longitude, 1)
    if c.blank?
      render :json => {:status => 'no_locations_found'}
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
    latitude.blank? || longitude.blank? ? return : true
    
    #summon the cart
    call = course.notify_carts(latitude, longitude)
    
    if call.blank?
      render :json => {:status => 'error'}
    else
      render :json => {:status => 'success', :result => call.as_json}
      Pusher["#{course.id}_carts"].trigger('summon_cart', call.as_json)
    end
  end
  
  def accept_summon
    #params
    s = params[:summon_id]
    
    #check for values
    s.blank? ? return : s = Summon.find(s) #set summon
    
    #flag summon as accepted
    result = s.accept
    
    if result.blank?
      render :json => {:status => 'error'}
    else
      render :json => {:status => 'success', :result => result.as_json, :summon => s.as_json}
      Pusher["#{s.course_id}_carts"].trigger('accept_summon', :result => result.as_json, :summon => s.as_json)
      Pusher["#{s.id}_summon_feed"].trigger('accept_summon', :result => result.as_json, :summon => s.as_json)
    end
  end
  
  def serve_summon
    #params
    s = params[:summon_id]
    
    #check for values
    s.blank? ? return : s = Summon.find(s) #set summon
    
    #flag summon as accepted
    result = s.serve
    
    if result.blank?
      render :json => {:status => 'error'}
    else
      render :json => {:status => 'success', :result => result.as_json, :summon => s.as_json}
      Pusher["#{s.course_id}_carts"].trigger('serve_summon', :result => result.as_json, :summon => s.as_json)
      Pusher["#{s.id}_summon_feed"].trigger('serve_summon', :result => result.as_json, :summon => s.as_json)
    end
  end
end