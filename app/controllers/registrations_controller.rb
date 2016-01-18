class RegistrationsController < Devise::RegistrationsController
  before_action :event

  protected

  def update_resource(resource, params)
    if needs_password? resource, params
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end

  def after_update_path_for(resource)
    event_submissions_path(@event)
  end

  private
  def needs_password?(user, params)
    user.email != params[:email] ||
      params[:password].present?
  end
end
