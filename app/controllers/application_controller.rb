class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    render "errors/not_found", status: 404
  end

end
