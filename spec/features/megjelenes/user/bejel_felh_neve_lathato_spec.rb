require 'spec_helper'

feature "A bejelentkezett " do

  scenario 'felhasználó neve megjelenik a menüsoron' do  
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    page.should have_link(user.email)
  end
end