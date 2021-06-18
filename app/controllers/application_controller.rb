class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    render "errors/not_found", status: 404
  end

end
