require 'spec_helper'

feature "Tervezett anyag sor szerkeszthető" do
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

  scenario 'szerkeszthető' do
    fill_in 'Mennyiség a tervezett anyagból', with: "1234"
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("38-as N+F tégla : 1234.0 klts")
  end

  scenario 'üres mennyiség mezővel nem fogadható el' do
    fill_in 'Mennyiség a tervezett anyagból', with: ""
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("nincs megadva")
  end

  scenario 'nem számot tartalmazó mennyiség mezővel nem fogadható el' do
    fill_in 'Mennyiség a tervezett anyagból', with: "qweiuh"
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("nem szám")
  end

  scenario 'negatív számot tartalmazó mennyiség mezővel nem fogadható el' do
    fill_in 'Mennyiség a tervezett anyagból', with: "-10"
    click_button 'Anyag sor frissítése'
    expect(page).to have_content("nagyobb kell legyen, mint 0")
  end
end