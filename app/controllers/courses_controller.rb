class CoursesController < ApplicationController

   before_action :authenticate_user!

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.teacher_id = current_user.id

    if @course.save
      redirect_to root_path, notice: 'You have Successfully created a new class. Now you can add Students!'
    else
      flash.now[:warning] = 'Say Again?'
      render 'new'
    end
  end


  def edit
    @course =  Course.find(params[:id])
    (@course.size - @course.enrollments.length).times {|i| @course.enrollments.build(seat: i)}
    @student_pool = current_user.student_pool.order(:last_name)
  end

  def update
    @course =  Course.find(params[:id])
    @student_pool = current_user.student_pool.order(:last_name)
    @enrollments = @course.enrollments
    binding.pry

    if @course.update(course_params)
      redirect_to root_path, notice: 'Your wish is my command!'
    else

      flash.now[:warning] = 'Take a look at what you got. Something went wrong.'
      render 'edit'
    end
  end

  private

  def update_course_and_seating
    @course.update(course_params)
  end

  def course_params
    params.require(:course).permit(
      :id,
      :subject,
      :school_year,
      :period,
      :start_date,
      :end_date,
      :status,
      :rows,
      :columns,
      enrollments_attributes: [:id, :seat, :student_id]
      )
  end
end
