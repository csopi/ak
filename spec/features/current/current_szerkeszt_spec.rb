require 'spec_helper'

feature "Beszállított anyag sor szerkeszthető" do
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

  scenario 'szerkeszthető' do
    fill_in 'Mennyiség az anyagból', with: "1234"
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("38-as N+F tégla 1234.0 klts")
  end

  scenario 'dátum változtatható' do
    select "2014", from: 'current[delivery(1i)]'
    select "április", from: 'current[delivery(2i)]'
    select "1", from: 'current[delivery(3i)]'
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("38-as N+F tégla 45.0 klts Szállítólevél: RT2365 2014-04-01")
  end

  scenario 'üres mennyiség mezővel nem fogadható el' do
    fill_in 'Mennyiség az anyagból', with: ""
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("nincs megadva")
  end

  scenario 'nem számot tartalmazó mennyiség mezővel nem fogadható el' do
    fill_in 'Mennyiség az anyagból', with: "qweiuh"
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("nem szám")
  end

  scenario 'negatív számot tartalmazó mennyiség mezővel nem fogadható el' do
    fill_in 'Mennyiség az anyagból', with: "-10"
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("nagyobb kell legyen, mint 0")
  end

  scenario 'üres bizonylat sorral nem fogadható el' do
    fill_in 'A bizonylat neve és száma', with: ""
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("nincs megadva")
  end
end