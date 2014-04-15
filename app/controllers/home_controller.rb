class HomeController < ApplicationController

  before_action :authenticate_user!
  before_action :route_principal_to_admin_page

  def index
    @schools = current_user.schools
    @requests = current_user.submitted_requests
    @courses = current_user.courses

  end

  def route_principal_to_admin_page
    if current_user && current_user.admin
      redirect_to admin_schools_path
    end
  end
end
