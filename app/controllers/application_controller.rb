class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  #include in api controler
  #include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  def resource_name
    :teacher
  end

  def resource
    @resource ||= Teacher.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:teacher]
  end

  helper_method :resource, :resource_name, :devise_mapping


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :rut])
  end

  def authenticate_teacher!
    if teacher_signed_in?
      super
    else
      redirect_to welcome_home_path, :notice => 'if you want to add a notice'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

end
