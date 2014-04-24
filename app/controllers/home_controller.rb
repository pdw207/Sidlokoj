class HomeController < ApplicationController

  before_action :authenticate_user!
  before_action :route_principal_to_admin_page

  def index
    @schools = current_user.schools
    @student_pool = current_user.student_pool
    @requests = current_user.submitted_requests.where(status: "Pending")
    @courses = Course.active_courses_for(current_user).includes(:students)

  end

  def route_principal_to_admin_page
    if current_user && current_user.admin
      redirect_to admin_home_index_path
    end
  end
end
