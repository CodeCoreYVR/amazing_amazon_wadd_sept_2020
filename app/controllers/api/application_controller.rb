class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def authenticate_user!
    render(
      json: { errors: "You are not logged in" },
      status: 422,
    ) unless user_signed_in?
  end
end
