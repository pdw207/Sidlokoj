
require 'spec_helper'

feature 'School Invite Requests', %q{
  I am a Principal
  who wants to limit which teachers can
  access a specific school
  to ensure student privacy.} do

  # Acceptance Criteria
  # * As a principal that serves as an admin for a school an can accept teacher join requests
  # * A principal may invite teachers to join the school that are already in the system

  scenario 'A Principal can create a School' do

    initial_school_count = School.count

    sign_in_as(FactoryGirl.create(:user, admin: true))

    visit admin_home_index_path

    click_link 'New School'
    fill_in 'Name', with: 'Washington PS 12'
    fill_in 'Location', with: 'Brooklyn, NY'
    fill_in 'Phone Number', with: '121-451-4512'
    click_button 'Create'

    expect(School.count).to eq(initial_school_count + 1)
    expect(page).to have_content('You have successfully setup a new School.')
  end

  scenario 'Even a prinicpal cam make a mistake -- on a new school form' do

    initial_school_count = School.count

    sign_in_as(FactoryGirl.create(:principal))

    visit admin_home_index_path
    click_link 'New School'
    click_button 'Create'

    expect(School.count).to eq(initial_school_count)
    expect(page).to have_content("can't be blank")
  end


  scenario 'A Teacher can not create a School' do
     sign_in_as(FactoryGirl.create(:teacher))
     visit admin_home_index_path
     expect(page).to have_content('Access Denied')
  end

  scenario "A Principal can edit school information" do

    school = FactoryGirl.create(:school)
    sign_in_as(FactoryGirl.create(:principal))
    visit edit_admin_school_path(school)
    fill_in 'Phone Number', with: '605-345-1254'
    click_button 'Update'

    expect(page).to have_content('Your update has been saved.')
  end

  scenario "A Principal can make a mistake editing school information" do

    school = FactoryGirl.create(:school)
    sign_in_as(FactoryGirl.create(:principal))

    visit edit_admin_school_path(school)
    fill_in 'Name', with: ''
    click_button 'Update'

    expect(page).to have_content('There is an error with your form.')
  end

  scenario 'Teacher can request to join a school' do

    # Create 1 school connected to a principal
    school = FactoryGirl.create(:school, name: 'Washington Avenue')
    principal = school.principal

    sign_in_as(FactoryGirl.create(:teacher))

    # Lets add the new school
    visit new_request_path
    select(principal.full_name, :from => 'School Principal')
    click_button 'Send Request'

    expect(page).to have_content('Your request has been sent to the Principal for approval')

  end

  scenario 'Principal can Approve a Teachers Request to Join a School' do
    teacher = FactoryGirl.create(:teacher)
    principal = FactoryGirl.create(:principal)
    school = FactoryGirl.create(:school)
    request = Request.create(principal: principal, teacher: teacher)
    principal.principal_school = school

    sign_in_as(principal)
    visit edit_admin_request_path(request)

    choose('Approved')
    click_button 'Save'

    expect(page).to have_content('Thank you for your response.')
  end

end














