class ApplicationController < ActionController::Base
  require 'httparty'
  require 'nass_api'
  require 'eia_api'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  caches_page :crop_assumptions
  caches_page :livestock_assumptions
  caches_page :links

  def livestock_assumptions
  end

  def crop_assumptions
  end
end
