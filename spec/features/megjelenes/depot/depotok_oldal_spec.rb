require 'spec_helper'

feature "Raktári anyagok oldal" do
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
  end

  scenario "címe 'AK-Raktár'" do
    expect(page).to have_title('AK-Raktár')
    expect(page).not_to have_title('AK - Depotta')
  end

  scenario "helyesen tartalmazza a raktár oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link('Raktár')
    expect(page).to have_link('Anyagok')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h2', text: 'A raktározott anyagok')
    expect(page).to have_selector('tr', depot.item.name)
    expect(page).to have_selector('tr', depot.item.unit.name)
    expect(page).to have_selector('tr', depot.quantity)
    expect(page).to have_selector('tr', depot.pass)
    expect(page).to have_selector('tr', depot.delivery)
    expect(page).to have_link('Anyag raktározás')
  end
end