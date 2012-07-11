class AdminController < ApplicationController
  layout "admin"
  
  def index
    @courses = Course.all
    render "/admin/index"
  end
  
end
