class IndexController < ApplicationController
  before_filter :cart_cookie, :only => [ :cart_view, :view_summoner_on_map ]
  
  def index
    render :nothing => true
  end
  
  def summoner_view
    render "/index/summoner", :layout => "front_end"
  end
  
  def view_summoner_on_map
    @summon = Summon.find(params[:summon_id])
    render "/golfer/view_summon_on_map", :layout => "front_end"
  end
  
  def cart_view
    render "/index/cart", :layout => "front_end"
  end
  
end
