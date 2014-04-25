require 'spec_helper'

feature 'Assign Students to Course', %q{
  I am a teacher managing a course
  I would like to add students to my course
  so I can view seating assignments of students.} do

  # Acceptance Criteria
  # *I can assign my students to my active classrooms
  # *The default seating position is last_name alpha

  scenario 'I can add a student to an existing classroom from the student pool' do

    enrollment = FactoryGirl.create(:enrollment)
    teacher = enrollment.course.teacher
    TeacherAssignment.create(teacher: teacher, school:enrollment.student.school)
    sign_in_as(teacher)
    visit edit_course_path(enrollment.course)

    select enrollment.student.full_name, from: "course_enrollments_attributes_0_student_id"
    click_button 'Modify'
    expect(page).to have_content('Your wish is my command!')
  end

  scenario 'I can switch the placement of two students' do
    course = FactoryGirl.create(:course)
    # Same course and same teacher 2 students
    kyle = FactoryGirl.create(:enrollment, course: course, seat: 0)
    kyle_2 = FactoryGirl.create(:enrollment, course: course, seat: 1)

    TeacherAssignment.create(teacher: course.teacher, school:kyle.student.school)
    TeacherAssignment.create(teacher: course.teacher, school:kyle_2.student.school)

    sign_in_as(course.teacher)
    visit edit_course_path(course)

    select kyle.student.full_name, from: "course_enrollments_attributes_1_student_id"
    select kyle_2.student.full_name, from: "course_enrollments_attributes_0_student_id"
    click_button 'Modify'
    expect(page).to have_content('Your wish is my command!')

  end
end
