require 'spec_helper'

feature "Anyag szerkesztése" do
  let!(:user) do
    user = FactoryGirl.create(:user)
  end

  let!(:item) do
    item = FactoryGirl.create(:item)
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
    visit '/items'
    click_link 'Anyag szerkesztése'
  end

  scenario "címe 'AK-Anyag szerkesztése'" do
    expect(page).to have_title('AK-Anyag szerkesztése')
    expect(page).not_to have_title('AK - Anyagoló')
  end

  scenario "helyesen tartalmazza az anyag szerkesztése oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Anyag szerkesztése')
    expect(page).to have_text('Az anyag neve')
    expect(page).to have_field("item_name", :with => item.name)
    expect(page).to have_text('Az anyag mértékegysége')
    expect(page).to have_field("item_unit_id")
    expect(page).to have_button('Anyag frissítése')
  end
end