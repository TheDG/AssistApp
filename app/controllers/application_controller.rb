class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # include in api controler
  # include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(teacher)
    welcome_home_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :rut])
  end

  def authenticate_teacher!
    if teacher_signed_in?
      super
    else
      redirect_to welcome_home_path, notice: 'Not a teacher', status: 401
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def authenticate_admin!
    if current_teacher.admin == true
    else
      redirect_to welcome_home_path, notice: 'Not a teacher', status: 401
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
end
