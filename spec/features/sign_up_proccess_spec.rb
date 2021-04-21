require 'rails_helper'

RSpec.feature "Sign Up Processes", type: :feature do
  it 'Return success if new user created' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Name', with: 'user'
      fill_in 'Email', with: 'user@mail.com'
      fill_in 'Password', with: 'tester'
      fill_in 'Password confirmation', with: 'tester'
    end
    click_button 'Sign up'
    expect(page.status_code).to be(200)
    expect(current_path).to eq(root_path)
  end

  it 'Raise error on non matching passwords' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Name', with: 'user'
      fill_in 'Email', with: 'user@mail.com'
      fill_in 'Password', with: 'tester'
      fill_in 'Password confirmation', with: 'testr'
    end
    click_button 'Sign up'
    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end

  it 'Raise error on email already been taken' do
    User.create(email: 'user@mail.com', password: 'tester', name: 'user')
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Name', with: 'user'
      fill_in 'Email', with: 'user@mail.com'
      fill_in 'Password', with: 'tester'
      fill_in 'Password confirmation', with: 'tester'
    end
    click_button 'Sign up'
    expect(page).to have_content 'Email has already been taken'
  end
end
