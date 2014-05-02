require 'spec_helper'

feature "Raktári anyagok összesítése" do
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

  let!(:depot_ketto) do
      FactoryGirl.create(:depot, id: 2, item_id: 1, quantity: "40")
  end  

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    first(:link, 'Kimutatások').click
    first(:link, 'Raktári anyagok összesítése').click
  end

  scenario "címe 'AK-Raktári anyagok'" do
    expect(page).to have_title('AK-Raktári anyagok')
    expect(page).not_to have_title('AK - Anyagok')
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
    page.should have_selector('h2', text: 'A raktári anyagok mennyisége összesítve')
    expect(page).to have_selector('tr', depot.item.name)
    expect(page).to have_selector('tr', depot.item.unit.name)
    expect(page).to have_selector('tr', depot.quantity)
    page.should have_selector('td', text: '38-as N+F tégla')
    page.should have_selector('td', text: '85')
    page.should have_selector('td', text: 'klts')
  end
end