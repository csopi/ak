require 'spec_helper'

feature "Anyag beszállítható a projektre" do
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

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    first(:link, 'Első projektem').click
    click_link 'Anyag beszállítás'
  end

  scenario 'létrehozható' do
    find('#current_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség az anyagból', with: "5827.36"
    fill_in 'A bizonylat neve és száma', with: "Szállító: 324876"
    select "2014", from: 'current[delivery(1i)]'
    select "április", from: 'current[delivery(2i)]'
    select "1", from: 'current[delivery(3i)]'
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("38-as N+F tégla 5827.36 klts Szállító: 324876")
  end

  scenario 'üres mennyiség és bizonylat mezővel nem jön létre anyag sor' do
    find('#current_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség az anyagból', with: ""
    fill_in 'A bizonylat neve és száma', with: ""
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("nincs megadva")
  end

  scenario 'üres mennyiség mezővel nem jön létre anyag sor' do
    find('#current_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség az anyagból', with: ""
    fill_in 'A bizonylat neve és száma', with: "Számla: 10"
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("nincs megadva")
  end

  scenario 'üres bizonylat mezővel nem jön létre anyag sor' do
    find('#current_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség az anyagból', with: "43.76"
    fill_in 'A bizonylat neve és száma', with: ""
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("nincs megadva")
  end

  scenario 'helytelen adattal kitöltött mennyiség mezővel nem jön létre anyag sor' do
    find('#current_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség az anyagból', with: "qwqe34"
    fill_in 'A bizonylat neve és száma', with: "Számla: 2009"
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("nem szám")
  end
end