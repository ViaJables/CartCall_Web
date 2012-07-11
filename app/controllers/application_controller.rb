require 'pusher'

Pusher.app_id = '23711'
Pusher.key = '199ae07749c9a979af5c'
Pusher.secret = 'f6232154fc48eeb2d046'

class ApplicationController < ActionController::Base
  protect_from_forgery
end
