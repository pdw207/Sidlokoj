class StudentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    binding.pry
    if @student.save
      redirect_to new_student_path, notice: 'You have Successfully added a Student. Add another.'
    else
      flash.now[:warning] = 'Hey, check the form again.'
      render 'new'
    end
  end

  def edit
    @student = Student.find(params[:id])

  end

  def update
    @student = Student.find(params[:id])

    if @student.update(student_params)
      redirect_to root_path, notice: 'Updated the student file.'
    else
      flash.now[:warning] = 'Take a look at your  edit again.'
      render 'edit'
    end

  end

  private

  def student_params
    params.require(:student).permit(:id, :first_name, :last_name, :nickname, :dob, :school_id)
  end
end
