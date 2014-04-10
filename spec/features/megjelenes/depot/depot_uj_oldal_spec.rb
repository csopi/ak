require 'spec_helper'

feature "Raktári anyag felvitele oldal" do
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

  let!(:depot) do
      FactoryGirl.create(:depot)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button 'Bejelentkezés'
    click_link 'Raktár'
    click_link 'Anyag raktározás'
  end

  scenario "címe 'AK-Anyag raktárba szállítása'" do
    expect(page).to have_title('AK-Anyag raktárba szállítása')
    expect(page).not_to have_title('AK - Depotba')
  end

  scenario "helyesen tartalmazza az új raktári anyag felvitele oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link('Raktár')
    expect(page).to have_link('Anyagok')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Anyag felvitele raktárba')
    expect(page).to have_text('A beszállítandó anyag neve')
    expect(page).to have_field("depot_item_id") 
    expect(page).to have_text('Mennyiség a beszállítandó anyagból')
    expect(page).to have_field("depot_quantity")
    expect(page).to have_text('A bizonylat neve és száma, megjegyzés')
    expect(page).to have_field("depot_pass")
    expect(page).to have_text('A beszállítás időpontja')
    expect(page).to have_field("depot[delivery(1i)]")
    expect(page).to have_button('Anyag raktározása')
  end
end