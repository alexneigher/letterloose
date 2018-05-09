class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  def after_sign_in_path_for(resource)
    #if this is true, they tried to create a tweak w/o being logged in
    if session[:tweak_params].present?
      service = TweakCreateService.new(session[:tweak_params], current_user).perform

      @title = service.title
      @tweak = service.tweak
      @description = service.description
      @descriptions = service.descriptions
      @create = true #makes the sound go

      session[:tweak_params] = nil #reset the session so it doesnt create it again

      title_tweak_path(@title, @tweak)
    else
      root_path
    end
  end
  
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
