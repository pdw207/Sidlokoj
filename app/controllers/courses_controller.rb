class CoursesController < ApplicationController

   before_action :authenticate_user!

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to root_path, notice: 'You have Successfully created a new class. Now you can add Students!'
    else
      flash.now[:warning] = 'Say Again?'
      render 'new'
    end
  end

  def edit
    @course =  Course.find(params[:id])
  end

  def update
    @course =  Course.find(params[:id])

    if @course.update(course_params)
      redirect_to root_path, notice: 'Your wish is my command!'
    else
      flash.now[:warning] = 'Take a look at what you got. Something went wrong.'
      render 'edit'
    end
  end

  private

  def course_params
    params.require(:course).permit(:id, :subject, :school_year, :period, :start_date, :end_date, :status)
  end
end
