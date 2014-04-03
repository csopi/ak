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
    first(:link, 'Sor szerkesztése').click
  end

  scenario "címe 'AK-Tervezett anyag szerkesztése'" do
    expect(page).to have_title('AK-Tervezett anyag szerkesztése')
    expect(page).not_to have_title('AK - Valami más')
  end

  scenario "helyesen tartalmazza az anyag szerkesztése oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link('Anyagok')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Tervezett anyag sor módosítása')
    page.should have_selector('h4', text: '38-as N+F tégla')
    expect(page).to have_text('Mennyiség a tervezett anyagból')
    expect(page).to have_field("plan_quantity")
    expect(page).to have_button('Anyag sor frissítése')
  end
end