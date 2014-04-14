class RequestsController < ApplicationController

  before_action :authenticate_user!

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.teacher = current_user
    if @request.save
      redirect_to root_path, notice: 'Your request has been sent to the Principal for approval'
    else
      flash.now[:warning] = 'Say Again?'
      render 'new'
    end
  end

  private

  def request_params
    params.require(:request).permit(:principal_id)
  end
end
