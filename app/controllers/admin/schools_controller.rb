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
    @school.principal = current_user
    if @school.save
      redirect_to admin_home_index_path, notice: 'You have successfully setup a new School.'
    else
      render 'new'
    end
  end

  def edit
    @school =  School.find(params[:id])
  end

  def update
    @school =  School.find(params[:id])

    if @school.update(school_params)
      redirect_to admin_home_index_path, notice: 'Your update has been saved.'
    else
      flash.now[:warning] = 'There is an error with your form.'
      render 'edit'
    end
  end



  private

  def school_params
    school_params = params.require(:school).permit(:id, :name, :location, :phone_number)
  end

  def authorize_principal
    unless current_user && current_user.admin
      flash[:error] = 'Access Denied'
      redirect_to root_path
    end
  end


end
