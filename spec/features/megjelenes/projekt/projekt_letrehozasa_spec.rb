require 'spec_helper'

feature "Új projekt létrehozása" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:project) do
      project = FactoryGirl.create(:project)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    click_link 'Új projekt'
  end

  scenario "címe 'AK-Projekt szerkesztése' kell legyen" do
    expect(page).to have_title('AK-Projekt létrehozása')
    expect(page).not_to have_title('AK - Ez+az')
  end

  scenario "helyesen tartalmazza a Projekt létrehozása oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Projekt létrehozása')
    expect(page).to have_text('A projekt neve')
    expect(page).to have_text('A projekt adatai')
    expect(page).to have_button('Projekt létrehozása')
  end
end