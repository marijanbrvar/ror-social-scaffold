require 'rails_helper'

RSpec.feature 'Sign in process', type: :feature do
  before(:each) do
    User.create(email: 'user@mail.com', password: 'tester', name: 'user')
  end

  it 'Sign existing user' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'user@mail.com'
      fill_in 'Password', with: 'tester'
    end
    click_button 'Log in'
    expect(current_path).to eq(root_path)
  end

  it 'Response 200 when visits page' do
    visit '/users/sign_in'
    expect(page.status_code).to be(200)
  end
end
