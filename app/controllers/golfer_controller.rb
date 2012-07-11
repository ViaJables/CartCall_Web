class GolferController < ApplicationController
  
    #### update your location to the cart ####
  def update_position
    latitude = params[:latitude]
    longitude = params[:longitude]
    s_id = params[:summon_id]
    
    s_id.blank? ? return : s = Summon.find(s_id)
    latitude.blank? || longitude.blank? ? return : true
    
    #update the summons location
    result = s.update_position(latitude, longitude)
    
    if result == false
      render :json => {:status => 'error'}
    else
      render :json => {:status => 'success', :result => result.as_json, :summon => s.as_json}
      Pusher["#{s.course_id}_carts"].trigger('update_summon', :result => result.as_json, :summon => s.as_json)
    end
    
  end
  
end
