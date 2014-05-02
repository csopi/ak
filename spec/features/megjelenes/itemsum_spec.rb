require 'spec_helper'

feature "Az anyagok száma a rendszerben" do
  let!(:user) do
    user = FactoryGirl.create(:user)
  end

  let!(:project) do
    FactoryGirl.create(:project)
  end
  
  let!(:item) do
    FactoryGirl.create(:item)
  end

  let!(:item_ketto) do
    FactoryGirl.create(:item, name: 'Csempe', unit_id: 1)
  end

  let!(:unit) do
    FactoryGirl.create(:unit)
  end

  
  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    first(:link, 'Kimutatások').click
    first(:link, 'Az anyagok száma a rendszerben').click
  end

  scenario "címe 'AK-Az anyagok száma'" do
    expect(page).to have_title('AK-Az anyagok száma')
    expect(page).not_to have_title('AK - Anya')
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
    page.should have_selector('h6', text: '2')
  end

  let!(:item_harom) do
    FactoryGirl.create(:item, name: 'Járólap', unit_id: 1)
  end

  scenario "a számláló új anyag hozzáadása esetén a helyes értéket mutatja" do
    visit current_path
    page.should have_selector('h6', text: '3')
  end
end