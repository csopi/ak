require 'spec_helper'

feature "Anyagok listázása" do
  let!(:unit) do
    unit = FactoryGirl.create(:unit)
  end

  let!(:item) do
    item = FactoryGirl.create(:item)
  end

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
  end

  scenario "címe 'AK-Anyagok legyen" do
    expect(page).to have_title('AK-Anyagok')
    expect(page).not_to have_title('AK - Ezen')
  end

  scenario "helyesen tartalmazza az Anyagok oldal elemeit" do
    page.should have_selector('h1', text: 'Anyagok')
    expect(page).to have_link('Projektek')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    expect(page).to have_text('Anyag neve')
    expect(page).to have_text('Mértékegysége')
    expect(page).to have_selector('tr', item.name)
    expect(page).to have_selector('tr', item.unit.name)
    expect(page).to have_link('Anyag szerkesztése')
    expect(page).to have_link('Anyag törlése')
    expect(page).to have_link('Új anyag')
  end
end
