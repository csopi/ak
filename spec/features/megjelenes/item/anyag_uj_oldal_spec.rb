require 'spec_helper'

feature "Új anyag létrehozása" do
  let!(:user) do
    user = FactoryGirl.create(:user)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    visit '/items'
    click_link 'Új anyag'
  end

  scenario "címe 'AK-Anyag létrehozása'" do
    expect(page).to have_title('AK-Anyag létrehozása')
    expect(page).not_to have_title('AK - Nem anyag')
  end

  scenario "helyesen tartalmazza az új anyag létrehozása oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Anyag létrehozása')
    expect(page).to have_text('Az anyag neve')
    expect(page).to have_text('Az anyag mértékegysége')
    expect(page).to have_button('Anyag létrehozása')
  end
end