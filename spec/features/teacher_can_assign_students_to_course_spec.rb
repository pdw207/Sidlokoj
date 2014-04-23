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

    select "Kyle Munchkin the 1", from: "course_enrollments_attributes_0_student_id"
    click_button 'Modify'
    expect(page).to have_content('Class Updated Successfully')
    expect(course.students.count).to eq(1)

  end

end
