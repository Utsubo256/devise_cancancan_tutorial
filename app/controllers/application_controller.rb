class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :check_admin_authorization
  rescue_from CanCan::AccessDenied do |_exception|
    render json: { errors: "CanCan::AccessDenied!" }
  end

  def check_admin_authorization
    if request.path.start_with?('/admin')
      authorize! :access_admin_page
    end
  end
end
