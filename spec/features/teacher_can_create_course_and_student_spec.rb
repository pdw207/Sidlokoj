require 'spec_helper'


feature 'Adding Students and Classrooms', %q{
  As a teacher
  I can access my classrooms and students
  to make changes to my classrooms and students basic information.} do

  # Acceptance Criteria
  # *I can see a list of all classrooms names
  # *I can add new classrooms with subject name, and school_year, period, start, end
  # *In my classroom subject name and end are required (end because we want to know when to archive)
  # *I have a link to archived classes
  # *I have a link to all students and see both photos and names in print friendly format
  # *I have a link to update my basic info including first_name, last_name and password and upload a photo.require 'spec_helper'

  scenario 'Teacher Creates Class Successfully' do
    teacher = FactoryGirl.create(:teacher)

    sign_in_as(teacher)
    visit new_course_path

    fill_in 'Subject', with: "Physics"
    fill_in 'School Year', with: "Fall 2010"
    fill_in 'Period', with: "2"
    fill_in 'Rows in Classroom', with: "5"
    fill_in 'Students Per Row', with: "5"
    # Start Date
    select "2013", from: 'course_start_date_1i'
    select "April", from: 'course_start_date_2i'
    select "20", from: 'course_start_date_3i'
    # End Date
    select "2014", from: 'course_end_date_1i'
    select "January", from: 'course_end_date_2i'
    select "11", from: 'course_end_date_3i'
    click_button 'Create'

    expect(page).to have_content('You have Successfully created a new class. Now you can add Students!')

  end

  scenario 'Even teachers make mistakes with adding a new class' do

    sign_in_as(FactoryGirl.create(:teacher))
    click_link 'Create a New Class'
    click_button 'Create'

    expect(page).to have_content('Say Again?')

  end

  scenario 'Teacher Can Edit a Class Successfully' do
    course = FactoryGirl.create(:course)
    student = FactoryGirl.create(:student)
    sign_in_as(course.teacher)

    visit edit_course_path(course)
    select "Inactive", from: 'Status'
    select student.full_name, from: 'course_enrollments_attributes_0_student_id'
    click_button 'Modify'
    expect(page).to have_content('Your wish is my command!')
  end

  scenario 'Teacher Can Edit a Class Unsuccesfully' do
    course = FactoryGirl.create(:course)
    teacher = course.teacher
    sign_in_as(teacher)
    visit edit_course_path(course)

    within "#course_modify" do
      find(:css,"input").click
      save_and_open_page
    end

    within ".alert-box" do
      expect(page).to have_content("Take a look at what you got. Something went wrong.")
    end
  end

  scenario 'teacher can create a new student Successfully' do

    teacher = FactoryGirl.create(:teacher)
    school = FactoryGirl.create(:school)
    teacher.schools << school
    sign_in_as(teacher)

    visit new_student_path
    select school.name, from: 'School'
    fill_in 'First Name', with: "Bob"
    fill_in 'Last Name', with: "Smith"
    fill_in 'Nickname', with: "Bobby"
    fill_in 'Date of Birth', with: "12-12-14"
    click_button 'Submit'

    expect(page).to have_content('You have Successfully added a Student. Add another.')

  end

  scenario 'Even teachers can make mistakes with creating a student' do
    teacher = FactoryGirl.create(:teacher)
    sign_in_as(teacher)

    visit new_student_path
    click_button 'Submit'

    expect(page).to have_content('Hey, check the form again.')

  end

  scenario 'A teacher can successfully edit a student' do

    sign_in_as(FactoryGirl.create(:teacher))
    student = FactoryGirl.create(:student)

    visit edit_student_path(student)
    fill_in 'Last Name', with: "Paco"
    click_button 'Submit'
    expect(page).to have_content('Updated the student file.')
  end

  scenario 'A teacher can make a mistake editing a student' do
    sign_in_as(FactoryGirl.create(:teacher))
    student = FactoryGirl.create(:student)

    visit edit_student_path(student)
    fill_in 'Last Name', with: ""
    click_button 'Submit'
    expect(page).to have_content('Take a look at your  edit again.')
  end


end
