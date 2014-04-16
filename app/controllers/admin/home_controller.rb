class Admin::HomeController < ApplicationController

  before_action :authorize_principal

  def index
    @school = current_user.principal_school
    @requests = current_user.requests
  end

  private

  def authorize_principal
    unless current_user && current_user.admin
      flash[:error] = 'Access Denied'
      redirect_to root_path
    end
  end

end
