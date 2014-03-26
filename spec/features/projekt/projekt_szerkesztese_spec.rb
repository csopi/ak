require 'spec_helper'

feature "Projekt" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:project) do
      FactoryGirl.create(:project)
  end

  let!(:project_ketto) do
      FactoryGirl.create(:project, name: "Második projektem")
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    first(:link, 'Projekt név és leírás szerkesztése').click
  end

  scenario 'szerkeszthető' do
    fill_in 'A projekt neve', with: 'Változott a proj neve'
    fill_in 'A projekt adatai', with: 'Új adatok'
    click_button 'Projekt adatok frissítése'
    expect(page).to have_content("A projekt adatait sikeresen frissítette.")
  end

  scenario 'a szerkesztés során üres név mezővel nem menthető' do
    fill_in 'A projekt neve', with: ''
    fill_in 'A projekt adatai', with: 'Új adatok'
    click_button 'Projekt adatok frissítése'
    expect(page).to have_content("A név nincs megadva")
  end

  scenario 'a szerkesztés során már foglalt név mezővel nem menthető' do
    fill_in 'A projekt neve', with: project_ketto.name
    click_button 'Projekt adatok frissítése'
    expect(page).to have_content("A név már foglalt")
  end
end