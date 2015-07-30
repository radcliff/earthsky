class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  rescue_from Faraday::ConnectionFailed, with: :connection_failed

private
  def connection_failed
    head :service_unavailable and return
  end 
end
