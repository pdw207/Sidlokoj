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
    @student_pool = current_user.student_pool
  end

  def update
    @course =  Course.find(params[:id])
    course_size = course_params[:rows].to_i * course_params[:columns].to_i
    matrix_size = course_params[:enrollments_attributes].count

    if course_size > matrix_size
      (course_size - matrix_size).times {|i| @course.enrollments.build(seat: (i+1))}
    else

    end
    @student_pool = current_user.student_pool

    if @course.update(course_params)
      redirect_to root_path, notice: 'Your wish is my command!'
    else

      flash.now[:warning] = 'Take a look at what you got. Something went wrong.'
      render 'edit'
    end
  end

  private

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
