class ErrorsController < ApplicationController
  def not_found
    render file: "#{Rails.root}/public/404.html", status: 404
  end

  def internal_server_error
    render file: "#{Rails.root}/public/404.html", status: 500
  end
end
