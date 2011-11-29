class ApplicationController < ActionController::Base
  protect_from_forgery
  include FrontendHelpers::Html5Helper
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied."
    redirect_to root_url
  end
end
