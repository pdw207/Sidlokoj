require 'spec_helper'

feature 'Prinicipal Manages a School', %q{
  I am a Principal
  who wants to limit which teachers can
  access students from a specific school
  to ensure student privacy.} do

  # Acceptance Criteria
  # * As a principal I am a user that has one school.
  # * A principal may invite teachers to join the school that are already in the system
  # * All students in a school will be available to all teachers that are members of that school.

  scenario 'A Principal can create a School' do

    initial_school_count = School.count

    sign_in_as(FactoryGirl.create(:user, admin: true))

    visit admin_schools_path

    click_link 'New School'
    fill_in 'Name', with: 'Washington PS 12'
    fill_in 'Location', with: 'Brooklyn, NY'
    fill_in 'Phone Number', with: '121-451-4512'
    click_button 'Create'

    expect(School.count).to eq(initial_school_count + 1)
    expect(page).to have_content('You have setup a School. Now Add Students.')
  end

  scenario 'Even a prinicpal cam make a mistake -- on a new school form' do

    initial_school_count = School.count

    sign_in_as(FactoryGirl.create(:user, admin: true))

    visit admin_schools_path
    click_link 'New School'
    click_button 'Create'

    expect(School.count).to eq(initial_school_count)
    expect(page).to have_content("can't be blank")
  end

  scenario 'A Prinicipal can view only schools they manage' do

    # Create 20 schools
    FactoryGirl.create_list(:school, 20, location: 'Mars')

    # Create 1 entry connected to a principal
    principal = FactoryGirl.create(:principal)
    school = FactoryGirl.create_list(:school, 10, location: 'Earth', principal: principal )
    # principal.schools << school

    # Of 21 schools the principal has only 1
    expect(School.count).to eq(30)
    expect(principal.schools.count).to eq(10)

    sign_in_as(principal)
    visit admin_schools_path

    expect(page).to have_content('Earth')
    expect(page).to_not have_content('Mars')


  end

  scenario 'A Teacher can not create a School' do
     sign_in_as(FactoryGirl.create(:teacher))
     visit admin_schools_path
     expect(page).to have_content('Access Denied')
  end

  scenario "A Principal can edit a school's information" do

  end

  scenario 'Teacher can request to join a school' do

    # Create 1 school connected to a principal
    principal = FactoryGirl.create(:user, first_name: 'Captain', last_name: 'Planet' ,admin: true)
    principal.schools << FactoryGirl.create(:school, name: 'Washington Avenue')
    principal.save

    # Create 1 school already connected to the teacher
    teacher = FactoryGirl.create(:user)
    teacher.schools << FactoryGirl.create(:school, name: 'Newton South')
    teacher.save

    sign_in_as(teacher)

    # Home page should have only current school listed
    expect(page).to have_content('Newton South')
    expect(page).to_not have_content('Washington Avenue')

    # Lets add the new school
    click_link 'Join a School'

    select('Captain Planet', :from => 'School Principal')
    click_button 'Send Request'

    # Home page should now have 1 schools and 1 request open
    expect(page).to have_content('Newton South')
    expect(page).to have_content('Washington Avenue')

    expect(page).to have_content('Your request has been sent to the Principal for approval')

  end

  scenario 'Principal can Approve a Teachers Request to Join a School' do

     # Create 1 school connected to a principal
    principal = FactoryGirl.create(:user, first_name: 'Captain', last_name: 'Planet' ,admin: true)
    principal.schools << FactoryGirl.create(:school, name: 'Washington Avenue')
    principal.save

    # Have a Teacher sign in and make a request
    teacher = FactoryGirl.create(:user, first_name: 'Jerry')
    sign_in_as(teacher)

    click_link 'Join a School'
    select('Captain Planet', :from => 'School Principal')
    click_button 'Send Request'
    click_link 'Sign Out'

    # Sign into Principal and Approve the request
    sign_in_as(principal)
    visit edit_admin_request_path(Request.last.id)
    expect(page).to have_content('Jerry')
    expect(page).to have_content('Pending')
    choose('Approved')
    click_button 'Save'
    save_and_open_page

    expect(page).to have_content('Thank you for your response.')
    expect(page).to have_content('Jerry')
    expect(page).to have_content('Approved')
  end

end














