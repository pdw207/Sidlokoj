class ClassroomsController < ApplicationController

  before_action :authenticate_user!


  def index
    render text: "restricted page "
  end


end
