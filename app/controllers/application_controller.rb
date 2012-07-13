require 'pusher'

Pusher.app_id = '23711'
Pusher.key = '199ae07749c9a979af5c'
Pusher.secret = 'f6232154fc48eeb2d046'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def cart_cookie
    if cookies[:cart].nil?
      cart = Cart.create()
      cookies[:cart] = { :value => "#{cart.id}", :expires => Time.now + 120000}
      @cart_information = cookies[:cart]
      puts "Making new cookie"
    else
      @cart_information = cookies[:cart]
      puts "Eating old cookie"
    end
  end
  
end
