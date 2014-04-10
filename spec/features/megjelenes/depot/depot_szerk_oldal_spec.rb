require 'spec_helper'

feature "Raktári anyag oldal szerkesztése" do
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
    click_button "Bejelentkezés"
    click_link 'Raktár'
    first(:link, '38-as N+F tégla').click
  end

  scenario "címe 'AK-Raktári anyag szerkesztése'" do
    expect(page).to have_title('AK-Raktári anyag szerkesztése')
    expect(page).not_to have_title('AK - Depot')
  end

  scenario "helyesen tartalmazza a raktári anyag sor szerkesztése oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link('Raktár')
    expect(page).to have_link('Anyagok')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Raktári anyag sor módosítása')
    expect(page).to have_text('A beszállítandó anyag neve')
    expect(page).to have_field("depot_item_id") 
    expect(page).to have_text('Mennyiség a beszállítandó anyagból')
    expect(page).to have_field("depot_quantity")
    expect(page).to have_text('A bizonylat neve és száma, megjegyzés')
    expect(page).to have_field("depot_pass")
    expect(page).to have_text('A beszállítás időpontja')
    expect(page).to have_field("depot[delivery(1i)]")
    expect(page).to have_button('Raktári anyag sor frissítése')
  end
end