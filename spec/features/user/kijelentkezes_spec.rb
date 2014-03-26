require 'spec_helper'

feature "A felhasználó " do

  scenario ' ki tud jelentkezni' do  
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    click_link 'Kijelentkezés'
    expect(page).to have_no_link(user.email)
    expect(page).to have_content("A kijelentkezés sikeres.")
  end
end