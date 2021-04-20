require 'rails_helper'

RSpec.feature 'Sign In With Missing Elements', type: :feature do
  before(:each) do
    User.create(email: 'user@mail.com', password: 'tester', name: 'user')
  end

  it 'Raise error on wrong password' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: ''
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end
  it 'Raise error on wrong email' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: ''
      fill_in 'Password', with: 'tester'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'Raise error on empty fields' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end
end
