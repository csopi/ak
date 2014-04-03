require 'spec_helper'

feature "Tervezett anyag szerkesztése" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:project) do
      FactoryGirl.create(:project)
  end
  
  let!(:item) do
      FactoryGirl.create(:item)
  end

  let!(:unit) do
      FactoryGirl.create(:unit)
  end

  let!(:plan) do
      FactoryGirl.create(:plan)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    first(:link, 'Első projektem').click
    click_link 'Tervezett anyagfelhasználás'
    click_link 'Anyag hozzáadása'
  end

  scenario "címe 'AK-Új tervezett anyag'" do
    expect(page).to have_title('AK-Új tervezett anyag')
    expect(page).not_to have_title('AK - Valami')
  end

  scenario "helyesen tartalmazza az anyag hozzáadása oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link('Anyagok')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Tervezett anyag sor felvitele')
    expect(page).to have_field("plan_item_id", text: '38-as N+F tégla')
    expect(page).to have_text('Mennyiség a tervezett anyagból')
    expect(page).to have_field("plan_quantity")
    expect(page).to have_button('Anyag sor létrehozása')
  end
end