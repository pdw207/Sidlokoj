class Admin::RequestsController < ApplicationController

  before_action :authorize_principal

  def edit
    @request =  Request.find(params[:id])
  end

  def update
    @request =  Request.find(params[:id])

    if @request.update(request_params)
      #If request is approved assigns school to teacher
      @request.toggle_school

      redirect_to admin_home_index_path, notice: 'Thank you for your response.'
    else
      flash.now[:warning] = 'Please review the information. The response has not finished.'
      render 'edit'
    end
  end

  private

  def request_params
    request_id = params.require(:id).to_i
    params.require(:request).permit(:status)
  end


  def authorize_principal
    unless current_user && current_user.admin
      flash[:error] = 'Access Denied'
      redirect_to root_path
    end
  end


end
