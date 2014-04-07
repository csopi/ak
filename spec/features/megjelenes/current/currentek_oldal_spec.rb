require 'spec_helper'

feature "Beszállított anyag szerkesztése" do
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

  let!(:current) do
      FactoryGirl.create(:current)
  end

  let!(:current_ketto) do
      FactoryGirl.create(:current, id: 2, item_id: 1, project_id: 1, quantity: "20")
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    first(:link, 'Első projektem').click
  end

  scenario "címe 'AK-Projekt adatok'" do
    expect(page).to have_title('AK-Projekt adatok')
    expect(page).not_to have_title('AK - Valami más data')
  end

  scenario "helyesen tartalmazza az anyagokat" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link('Anyagok')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h2', text: 'Első projektem - beszállított anyagok')
    expect(page).to have_selector('tr', current.item.name)
    expect(page).to have_selector('tr', current.item.unit.name)
    expect(page).to have_selector('tr', current.quantity)
    expect(page).to have_selector('tr', current.pass)
    expect(page).to have_selector('tr', current.delivery)
    expect(page).to have_link('Sor törlése')
    expect(page).to have_link('Anyag beszállítás')
  end
end