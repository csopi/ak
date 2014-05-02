require 'spec_helper'

feature "Projekt - anyagkimutatás" do
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
    first(:link, 'Projekt kimutatás').click
  end

  scenario "címe 'AK-Projekt összesítő'" do
    expect(page).to have_title('AK-Projekt összesítő')
    expect(page).not_to have_title('AK - Projsum')
  end

  scenario "helyesen tartalmazza az anyag kimutatás oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link('Raktár')
    expect(page).to have_link('Anyagok')
    expect(page).to have_link('Kimutatások')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    expect(page).to have_link('Visszalépés a projekthez')
    page.should have_selector('h2', text: 'Első projektem - anyagkimutatás')
    expect(page).to have_selector('tr', current.item.name)
    expect(page).to have_selector('tr', current.item.unit.name)
    expect(page).to have_selector('tr', current.quantity)
    expect(page).to have_text('A tervezett mennyiség meghaladva: 59.33 klts többlet beszállítás történt az anyagból!')
    expect(page).to have_text('TERVEZETT ANYAGOK')
    expect(page).to have_text('AZ ELŐRE NEM TERVEZETT ANYAGOK')
  end
end