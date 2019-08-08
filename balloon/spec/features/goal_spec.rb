require 'spec_helper'
require 'rails_helper'

feature 'news feed' do
  given!(:user) { User.create(username: 'joe1', password: '123456') }
  given!(:g1) { Goal.create(title: 'Eat 10 hot dogs in one sitting',
    user_id: user.id, goal_type: 'public') }
  # debugger
  given!(:g2) { Goal.create(title: 'Private goal',
    user_id: user.id, goal_type: 'private') }

  background :each do
    visit goals_path
  end

  scenario 'user can view everyones goals' do
    expect(page).to have_content('Eat 10 hot dogs in one sitting')
  end

  scenario 'user cannot see private goals' do
    expect(page).to_not have_content('Private goal')
  end


end



feature 'personal goals' do
  given!(:user) { User.create(username: 'joe1', password: '123456') }
  given!(:g1) { Goal.create(title: 'Eat 10 hot dogs in one sitting',
    user_id: user.id, goal_type: 'public') }
  given!(:g2) { Goal.create(title: 'Private goal',
    user_id: user.id, goal_type: 'private') }

  background :each do
    visit user_goals_path(user)
  end

  scenario 'user can see all of their goals regardless of type' do
    save_and_open_page
    expect(page).to have_content('Eat 10 hot dogs in one sitting')
    expect(page).to have_content('Private goal')
  end


end