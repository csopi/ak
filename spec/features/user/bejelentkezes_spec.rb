require 'spec_helper'

feature "Bejelentkezés " do

  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
  end
  
  scenario 'lehetséges' do  
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    expect(page).to have_content("Sikeres bejelentkezés.")
  end

  scenario 'jelszó nélkül nem lehetséges' do
    fill_in 'A felhasználó email címe', with: "Kiss Natália"
    fill_in 'Jelszó', with: ""
    click_button "Bejelentkezés"
    expect(page).to have_content("Hibás email cím vagy jelszó.")
  end  

  scenario 'név nélkül nem lehetséges' do
    fill_in 'A felhasználó email címe', with: ""
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    expect(page).to have_content("Hibás email cím vagy jelszó.")
  end

  scenario 'jelszó és név nélkül nem lehetséges' do
    fill_in 'A felhasználó email címe', with: ""
    fill_in 'Jelszó', with: ""
    click_button "Bejelentkezés"
    expect(page).to have_content("Hibás email cím vagy jelszó.")
  end
end