class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token
  rescue_from StandardError, with: :standard_error

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def not_found
    render(
      json: {
        errors: [{
          type: "Not Found",
        }],
      },
      status: :not_found,
    )
  end

  private

  def authenticate_user!
    render(
      json: { errors: "You are not logged in" },
      status: 422,
    ) unless user_signed_in?
  end

  def standard_error(error)
    logger.error error.full_message

    render(
      status: 500,
      json: {
        status: 500,
        errors: [{
          type: error.class.to_s,
          message: error.message,
        }],
      },
    )
  end

  def record_not_found(error)
    render(
      status: 404,
      json: {
        status: 404,
        errors: [{
          type: error.class.to_s,
          message: error.message,
        }],
      },
    )
  end

  def record_invalid(error)
    invalid_record = error.record
    errors = invalid_record.errors.map do |field, message|
      {
        type: error.class.to_s,
        record_type: invalid_record.class.to_s,
        field: field,
        message: message,
      }
    end
    render(
      json: { status: 422, errors: errors },
      status: 422,
    )
  end
end
