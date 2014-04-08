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

  let!(:plan_ketto) do
      FactoryGirl.create(:plan, id: 2, item_id: 1, project_id: 1, quantity: "20")
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    first(:link, 'Első projektem').click
    click_link 'Tervezett anyagfelhasználás'
  end

  scenario "címe 'AK-Tervezett anyagfelhasználás'" do
    expect(page).to have_title('AK-Tervezett anyagfelhasználás')
    expect(page).not_to have_title('AK - Valami más dolog')
  end

  scenario "helyesen tartalmazza az anyagokat" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link('Anyagok')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h2', text: 'Első projektem - tervezett anyagfelhasználása')
    expect(page).to have_selector('tr', plan.item.name)
    expect(page).to have_selector('tr', plan.item.unit.name)
    expect(page).to have_link('Sor szerkesztése')
    expect(page).to have_link('Sor törlése')
    expect(page).to have_link('Anyag hozzáadása')
    expect(page).to have_link('Visszalépés a projekthez')
  end
end