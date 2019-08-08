require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  background :each do
    visit new_user_path
  end
  scenario 'has a new user page' do
    expect(page).to have_content('Sign up')
  end

  scenario 'takes a username and password' do
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end
end

feature 'signing up a user' do
  background :each do
    visit new_user_path
  end

  scenario 'shows username on the homepage after signup' do
    fill_in 'username', with: 'joe'
    fill_in 'password', with: '123456'
    click_button 'Sign up'
    expect(page).to have_content('joe')
    user = User.find_by(username: 'joe')
    expect(current_path).to eq(user_path(user))
  end

  scenario 'flashes errors with too short of a password' do

    fill_in 'username', with: 'joe'
    fill_in 'password', with: '123'
    click_button 'Sign up'
    # save_and_open_page
    expect(page).to have_content('Password is too short (minimum is 6 characters)')
  end
  scenario 'flashes errors when username taken' do
    User.create(username: 'joe', password: '123456')
    fill_in 'username', with: 'joe'
    fill_in 'password', with: '123456'
    click_button 'Sign up'
    # save_and_open_page
    expect(page).to have_content('Username has already been taken')
  end

end


feature 'logging in' do

  background :each do
    visit new_session_path
  end

  scenario 'logs in the user in and shows username on the homepage after login' do
    User.create(username: 'joe', password: '123456')
    fill_in 'username', with: 'joe'
    fill_in 'password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content('Sup joe')
  end

  scenario 'flashes errors if username or password incorrect' do 
    User.create(username: 'joe', password: '123456')
    fill_in 'username', with: 'stanton'
    fill_in 'password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content("incorrect username or password")

  end

end

feature 'logging out' do
  given!(:u1) { User.create(username: 'joe', password: '123456') }
  background :each do
    visit new_session_path
    fill_in 'username', with: 'joe'
    fill_in 'password', with: '123456'
    click_button 'Log in'
  end
  scenario 'begins with a logged in state' do
    expect(current_path).to eq(user_path(u1))
  end

  scenario 'displays logged out button if logged in' do
    expect(page).to have_content('Log out')
  end

  scenario 'doesn\'t show username on the homepage after logout' do 
    click_button 'Log out'
    expect(page).to_not have_content('Sup joe')
  end

end
