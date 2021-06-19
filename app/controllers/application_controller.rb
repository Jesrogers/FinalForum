class ApplicationController < ActionController::Base
  helper_method :breadcrumbs

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    render "errors/forbidden", status: 403
  end
end
