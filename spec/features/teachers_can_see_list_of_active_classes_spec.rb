require 'spec_helper'

feature 'Teacher Dashboard', %q{
  I am a teacher`
  I want to see only active classes
  so they don't clutter my homepage.} do

  it 'should not be included in view if inactive' do
    course = FactoryGirl.create(:course)
    sign_in_as(course.teacher)
    expect(page).to have_content(course.subject)
    visit edit_course_path(course)
    select 'Inactive'
    click_button 'Modify'
    expect(page).to_not have_content(course.subject)
  end

end
