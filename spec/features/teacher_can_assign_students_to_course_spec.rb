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

    sign_in_as(enrollment.course.teacher)
    visit edit_course_path(enrollment.course)
    select "Kyle Munchkin the 1", from: "course_enrollments_attributes_0_student_id"
    click_button 'Modify'
    expect(page).to have_content('Class Updated Successfully')
    expect(course.students.count).to eq(1)

  end
  scenario 'I can switch the placement of two students' do
    course = FactoryGirl.create(:course)
    # Same course and same teacher 2 students
    kyle = FactoryGirl.create(:enrollment, course: course, seat: 0)
    kyle_2 = FactoryGirl.create(:enrollment, course: course, seat: 1)

    sign_in_as(course.teacher)
    visit edit_course_path(course)

    select kyle.student.full_name, from: "course_enrollments_attributes_0_student_id"
    select kyle_2.student.full_name, from: "course_enrollments_attributes_1_student_id"
    click_button 'Modify'
    expect(page).to have_content('Class Updated Successfully')
    expect(course.students.count).to eq(2)

  end
end
