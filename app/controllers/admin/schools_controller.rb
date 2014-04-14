class Admin::SchoolsController < ApplicationController

  before_action :authorize_principal

  def index
    @schools = current_user.schools
    @requests = current_user.requests
  end


  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to admin_schools_path, notice: 'You have setup a School. Now Add Students.'
    else
      render 'new'
    end
  end

  private

  def school_params
    school_params = params.require(:school).permit(:name, :location, :phone_number, :principal)
    user_id = {"principal_id" => current_user.id}
    user_id.merge(school_params)
  end

  def authorize_principal
    unless current_user && current_user.admin
      flash[:error] = 'Access Denied'
      redirect_to root_path
    end
  end


end
