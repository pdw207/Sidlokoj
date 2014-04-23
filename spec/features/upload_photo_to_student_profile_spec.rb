require 'spec_helper'

feature 'Uploading Student Photos', %q{
  I am a teacher adding a Student
  I would like to upload a Photo
  in order to remember the student's face.} do

  # Acceptance Critera
  # * I can optionally include a photo of my car as part of my parking registration
  # * If I supply a photo, it must be a jpg, png, or gif
  # * If I supply a photo, it cannot exceed 5MB

  scenario 'teacher should successfully upload a photo' do

    sign_in_as(FactoryGirl.create(:teacher))

    visit new_student_path
    fill_in 'First Name', with: "Sara"
    fill_in 'Last Name', with: "Parkeru"
    attach_file 'Student Photo', Rails.root.join('spec/file_fixtures/valid_girl.png')
    click_button 'Submit'

    expect(page).to have_content('You have Successfully added a Student. Add another.')
    expect(Student.last.student_photo.url).to be_present
  end

  scenario 'teacher can unsuccessfully upload a photo based on file type' do

    sign_in_as(FactoryGirl.create(:teacher))
    visit new_student_path
    fill_in 'First Name', with: "Jerry"
    fill_in 'Last Name', with: "Smith"
    attach_file 'Student Photo', Rails.root.join('spec/file_fixtures/invalid_boy_type.php')
    click_button 'Submit'

    expect(page).to have_content('Hey, check the form again')

  end


end
