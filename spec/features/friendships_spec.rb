require 'rails_helper'

RSpec.feature "Friendships", type: :feature do
  before :each do
  	@user_one = User.create(name: 'user1', email: 'user1@email.com', password: 'tester')
  	@user_two = User.create(name: 'user2', email: 'user2@email.com', password: 'tester')
  	@user_three = User.create(name: 'user3', email: 'user3@email.com', password: 'tester')
  	@friendship = Friendship.create(user_id: @user_two.id, friend_id: @user_one.id)
  	@friendship = Friendship.create(user_id: @user_one.id, friend_id: @user_three.id)
  end

  it 'Accepts friendship from user' do
  	visit user_session_path
  	fill_in 'user[email]', with: @user_one.email
  	fill_in 'user[password]', with: @user_one.password
  	click_button 'Log in'
  	expect(page).to have_content('Signed in successfully.')
    click_on 'All users'
  	expect(page).to have_content('user2')
  	click_link 'accept'
  	expect(page).to have_content('Friendship accepted')
  end

  it 'Reject friendship from user One' do
  	visit user_session_path
  	fill_in 'user[email]', with: @user_three.email
  	fill_in 'user[password]', with: @user_three.password
  	click_button 'Log in'
  	expect(page).to have_content('Signed in successfully.')
    click_on 'All users'
  	expect(page).to have_content('user1')
  	click_link 'reject'
  	expect(page).to have_content('Unfriended successfully')
  end

end
