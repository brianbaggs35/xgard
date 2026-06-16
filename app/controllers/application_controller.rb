class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization
  allow_browser versions: :modern
  rescue_from Pundit::NotAuthorizedError, with: :handle_unauthorized

  private

  def handle_unauthorized
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end
end
