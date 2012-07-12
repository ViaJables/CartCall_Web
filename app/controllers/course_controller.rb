class CourseController < ApplicationController
  
  def find_course
    latitude = params[:latitude]
    longitude = params[:longitude]
    c = Course.get_nearby_courses(latitude, longitude, 500)
    if c.blank?
      render :json => {:status => 'no_locations_found'}
    else
      render :json => {:status => 'success', :result => c.as_json}
    end
  end
  
  def availability
    #params
    c = params[:course_id]
    
    #check for values
    c.blank? ? return : course = Course.find(c) #set course
    
    #summon the cart
    c = course.check_for_active_carts
    
    if c == false
      render :json => {:status => 'no_active_carts'}
    else
      render :json => {:status => 'success', :result => "active_carts"}
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
      # Tell Golfer App To Subscribe to CARTID_summon_feed
      render :json => {:status => 'success', :result => call.as_json}
      # Tell Cart Ladies What's Going Down
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
      # Tell Cart Ladies What's Going Down
      Pusher["#{s.course_id}_carts"].trigger('accept_summon', :result => result.as_json, :summon => s.as_json)
      # Tell the Golfer What's Going Down
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
      if request.xhr?
        render :json => {:status => 'error'}
      else
        redirect_to "/cart"
      end
    else
      if request.xhr?
        render :json => {:status => 'success', :result => result.as_json, :summon => s.as_json}
      else
        redirect_to "/cart"
      end
      # Tell Cart Ladies What's Going Down
      Pusher["#{s.course_id}_carts"].trigger('serve_summon', :result => result.as_json, :summon => s.as_json)
      # Tell the Golfer What's Going Down
      Pusher["#{s.id}_summon_feed"].trigger('serve_summon', :result => result.as_json, :summon => s.as_json)
    end
  end
  
  ####################
  # Cart Admin Calls #
  ####################
  
  def login
    course_pin = params[:course_pin]
    
    #check for values
    course_pin.blank? ? return : c = Course.find_by_pin(course_pin)
    
    if c.blank?
      render :json => {:status => 'invalid_pin'}
    else
      render :json => {:status => 'success', :result => c.as_json}
    end
  end
  
  def get_summons
    course_id = params[:course_id]
    
    #check for values
    course_id.blank? ? return : c = Course.find(course_id)
    
    if c.blank?
      render :json => {:status => 'invalid_course'}
    else
      s = c.summons.where(:served => nil)
      render :json => {:status => 'success', :result => s.as_json}
    end
  end
  
  
end