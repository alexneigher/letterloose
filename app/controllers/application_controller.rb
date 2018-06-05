class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  around_action :global_request_logging

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

    def global_request_logging 
      logger.info "USERAGENT: #{request.headers['HTTP_USER_AGENT']}"
      begin 
        yield 
      ensure 
        logger.info "response_status: #{response.status}"
      end 
    end 
end
