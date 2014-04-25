class CoursesController < ApplicationController

   before_action :authenticate_user!

  def index
      @courses = Course.active_courses_for(current_user).includes(:students)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.teacher_id = current_user.id

    @course.class_size.times {|i| @course.enrollments.build(seat: i)} unless @course.rows.nil? || @course.columns.nil?

    if @course.save
      redirect_to root_path, notice: 'You have Successfully created a new class. Now you can add Students!'
    else
      flash.now[:warning] = 'Say Again?'
      render 'new'
    end
  end


  def edit
    @course =  Course.find(params[:id])
    @student_pool = current_user.student_pool.order(:last_name)
    @enrollments = @course.enrollments.order(:seat)
  end

  def update
    @course =  Course.find(params[:id])
    @student_pool = current_user.student_pool.order(:last_name)
    @enrollments = @course.enrollments.order(:seat)

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
