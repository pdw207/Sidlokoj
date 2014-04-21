require 'spec_helper'

feature 'Assign Students to Course', %q{
  I am a teacher managing a course
  I would like to add students to my course
  so I can view seating assignments of students.} do

  # Acceptance Criteria
  # *I can assign my students to my active classrooms
  # *The default seating position is last_name alpha

  scenario 'I can add a student to an existing classroom from the student pool' do

    school = FactoryGirl.create(:school_with_students)
    course = FactoryGirl.create(:course)

    # The teacher of the course is a member of the school
    course.teacher.schools << school

    sign_in_as(course.teacher)
    visit edit_course_path(course)
    select "John", from: 'seat_1'
    select "Dale", from: 'seat_2'
    select "Joe", from: 'seat_3'
    click_button 'Modify'
    expect(page).to have_content('Class Updated Successfully')
    expect(chemistry.students.count).to eq(3)

  end

  scenario 'I can remove a student from an existing classoom'
  scenario 'I can add a student to a new classroom'
  scenario 'I can delete a student from a new classroom'
end
