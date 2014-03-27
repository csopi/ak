require 'spec_helper'

feature "Mértékegységek listázása" do
  let!(:unit) do
      unit = FactoryGirl.create(:unit)
  end

  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  scenario "címe 'AK-Mértékegységek legyen" do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    visit '/units'
    expect(page).to have_title('AK-Mértékegységek')
    expect(page).not_to have_title('AK - Igazgató')
  end

  scenario "helyesen tartalmazza a Mértékegységek oldal elemeit" do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    visit '/units'
    page.should have_selector('h1', text: 'Mértékegységek')
    expect(page).to have_link('Projektek')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    expect(page).to have_text('Mértékegység neve')
    expect(page).to have_selector('tr', unit.name)
    expect(page).to have_link('Új mértékegység')
  end
end