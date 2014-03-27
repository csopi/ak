require 'spec_helper'

feature "Új mértékegység létrehozása" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:unit) do
      unit = FactoryGirl.create(:unit)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    visit '/units'
    click_link 'Új mértékegység'
  end

  scenario "címe 'AK-Új mértékegység létrehozása'" do
    expect(page).to have_title('AK-Új mértékegység létrehozása')
    expect(page).not_to have_title('AK - Ez+az+amaz')
  end

  scenario "helyesen tartalmazza az új mértékegység létrehozása oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Mértékegység létrehozása')
    expect(page).to have_text('A mértékegység neve')
    expect(page).to have_button('Mértékegység létrehozása')
  end
end
