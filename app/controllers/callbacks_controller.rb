class CallbacksController < ApplicationController
  def index
    omniauth_data = request.env["omniauth.auth"]
    user = User.find_from_omniauth(omniauth_data)
    user ||= User.create_from_omniauth(omniauth_data)
    sign_in(user) # this is defined in the application_controller.rb to set the sessions[:user_id]
    redirect_to root_path, notice: "Thank you signing in!"
  end
end
