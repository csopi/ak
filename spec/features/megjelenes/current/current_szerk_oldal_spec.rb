require 'spec_helper'

feature "Beszállított anyag oldal szerkesztése" do
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

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    first(:link, 'Első projektem').click
    first(:link, '38-as N+F tégla').click
  end

  scenario "címe 'AK-Beszállított anyag sor szerkesztése'" do
    expect(page).to have_title('AK-Beszállított anyag sor szerkesztése')
    expect(page).not_to have_title('AK - Valami cím')
  end

  scenario "helyesen tartalmazza az anyag beszállítása oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link('Anyagok')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Beszállított anyag sor módosítása')
    page.should have_selector('h4', text: '38-as N+F tégla')
    expect(page).to have_text('Mennyiség az anyagból')
    expect(page).to have_field("current_quantity")
    expect(page).to have_text('A bizonylat neve')
    expect(page).to have_field("current_pass")
    expect(page).to have_text('A beszállítás időpontja')
    expect(page).to have_field("current[delivery(1i)]")
    expect(page).to have_button('Anyag sor frissítése')
  end
end