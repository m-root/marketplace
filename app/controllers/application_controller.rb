class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :get_categories

  def after_sign_in_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :first_name, :last_name, :email, :password, :password_confirmation
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit :first_name, :last_name, :email, :password, :password_confirmation, :current_password
    end
  end

  private

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def get_categories
    @categories = Category.all
  end

end

ActiveAdmin::ResourceController.class_eval do
  def find_resource
    resource_class.is_a?(FriendlyId) ? scoped_collection.where(slug: params[:id]).first! : scoped_collection.where(id: params[:id]).first!
  end
end
