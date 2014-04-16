require 'spec_helper'

feature 'User Sign Up and Sign In', %q{
  As a teacher
  I want the ability to access the site securely
  to protect my student's information.
  } do


  # Acceptance Criteria
  # ---------------------------
  # * As a new user I can register with first_name, last_name, password, password_confirm and email.
  # * All fields are required and password must be unique.
  # * As a new user I can authenticate my email and log-on to welcome page
  # * If I am a current user I can login to site with email and password to get to the welcome page
  # * If I input an invalid username or password I can make another attempt



  # Sign Up
  scenario 'an unregistered user completes sign_up form' do

    starting_user_count = User.count
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: "Mary"
    fill_in 'Last Name', with: "Undershill"
    fill_in 'Email', with: "undershill@gmail.com"
    choose('Teacher')
    fill_in 'user_password', with: "12345678"
    fill_in 'user_password_confirmation', with: "12345678"
    click_button 'Sign Up'

    expect(page).to have_content('Awesome. You are now registered. Now you need to create a classroom.')
    expect(User.count).to eq(starting_user_count + 1)

  end

  scenario 'a user does not supply all information in the sign_up form' do
    starting_user_count = User.count

    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content('Please review the problems below')
    expect(User.count).to eq(starting_user_count)

  end



  # Sign In
  scenario 'a user signs into the site successfully' do

    user = FactoryGirl.create(:user)
    sign_in_as(user)
    expect(page).to have_content('Nice to See you Again.')

  end

  scenario 'a user signs into the site unsuccessfull' do

    visit root_path
    click_link 'Sign In'
    click_button 'Sign In'
    expect(page).to have_content('Invalid email or password.')

  end


  #Sign Out
  scenario 'a user signs out' do

    user = FactoryGirl.create(:user)
    sign_in_as(user)

    click_link 'Sign Out'
    expect(page).to have_content("You need to sign in or sign up before continuin")

  end

  # Secure Pages
  scenario 'an unregistered user attempts to access a restricted page' do

    visit root_path
    expect(page).to have_content('You need to sign in or sign up before continuing')

  end

  scenario 'an unauthorized user attempts to acess a restricted page' do
     teacher = FactoryGirl.create(:teacher)
     sign_in_as(teacher)
     visit admin_home_index_path
     expect(page).to have_content('Access Denied')
  end

  scenario 'an authorized user successfully accesses restricted page' do
    principal = FactoryGirl.create(:principal)
    sign_in_as(principal)
    visit admin_home_index_path
    expect(page).to have_content("Principal #{principal.last_name}")
  end
end
