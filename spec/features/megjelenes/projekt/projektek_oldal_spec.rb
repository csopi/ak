require 'spec_helper'

feature "Projektek listázása" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:project) do
      project = FactoryGirl.create(:project)
  end

  scenario "címe 'AK-Projektek' kell legyen" do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    expect(page).to have_title('AK-Projektek')
    expect(page).not_to have_title('AK - Ez+az')
  end

  scenario "helyesen tartalmazza a Projektek oldal elemeit" do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    page.should have_selector('h1', text: 'Projektek')
    expect(page).to have_link('Projektek')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    expect(page).to have_text('A projekt neve')
    expect(page).to have_text('A projekt adatai')
    expect(page).to have_selector('tr', project.name)
    expect(page).to have_selector('tr', project.description)
    expect(page).to have_link('Új projekt')
  end
end