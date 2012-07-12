class AdminController < ApplicationController
  layout "admin"
  
  def index
    @courses = Course.all
    render "/admin/index"
  end
  
  def pusher_webhooks
    webhook = Pusher::WebHook.new(request)
    if webhook.valid?
      webhook.events.each do |event|
        t = event["channel"]
        if !t["carts"].nil?
          # Get Course Information
          course = Course.find(event["channel"].split("_").first)
          case event["name"]
          when 'channel_occupied'
            # Send Notification to Course Golfers telling them Carts are Available
            course.update_attribute(:active_carts, true)
          when 'channel_vacated'
            # Send Notification to Course Golfers telling them Carts May Not Be Available
            course.update_attribute(:active_carts, false)
          end
          Pusher["#{course.id}_course"].trigger('carts_active', :result => course.active_carts)
        elsif !t["course"].nil?
          
        elsif !t["summon_feed"].nil?
          
        end
      end
      render text: 'ok'
    else
      render text: 'invalid', status: 401
    end
  end
  
end
