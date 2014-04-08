require 'spec_helper'

feature "Raktári sor létrehozható" do
  let!(:user) do
      user = FactoryGirl.create(:user)
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
    click_link 'Raktár'
    click_link 'Anyag raktározás'
  end

  scenario 'beszállítható' do
    find('#depot_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a beszállítandó anyagból', with: "10"
    fill_in 'A bizonylat neve és száma, megjegyzés', with: "Szállítólevél: 987"
    select "2014", from: 'depot[delivery(1i)]'
    select "április", from: 'depot[delivery(2i)]'
    select "1", from: 'depot[delivery(3i)]'
    click_button 'Anyag raktározása'
    expect(page).to have_content("38-as N+F tégla 10.0 klts 2014-04-01 Szállítólevél: 987")
  end

  scenario 'üres mennyiség és bizonylat mezővel nem jön létre raktári sor' do
    find('#depot_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a beszállítandó anyagból', with: ""
    fill_in 'A bizonylat neve és száma, megjegyzés', with: ""
    select "2014", from: 'depot[delivery(1i)]'
    select "április", from: 'depot[delivery(2i)]'
    select "1", from: 'depot[delivery(3i)]'
    click_button 'Anyag raktározása'
    expect(page).to have_content("hibát kérem javítson ki")
  end

  scenario 'üres mennyiség mezővel nem jön létre raktári sor' do
    find('#depot_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a beszállítandó anyagból', with: ""
    fill_in 'A bizonylat neve és száma, megjegyzés', with: "Szállító: 10"
    select "2014", from: 'depot[delivery(1i)]'
    select "április", from: 'depot[delivery(2i)]'
    select "1", from: 'depot[delivery(3i)]'
    click_button 'Anyag raktározása'
    expect(page).to have_content("hibát kérem javítson ki")
  end

  scenario 'üres bizonylat mezővel nem jön létre raktári sor' do
    find('#depot_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a beszállítandó anyagból', with: "10"
    fill_in 'A bizonylat neve és száma, megjegyzés', with: ""
    select "2014", from: 'depot[delivery(1i)]'
    select "április", from: 'depot[delivery(2i)]'
    select "1", from: 'depot[delivery(3i)]'
    click_button 'Anyag raktározása'
    expect(page).to have_content("hibát kérem javítson ki")
  end

  scenario 'helytelenül kitöltött mennyiség mezővel nem jön létre raktári sor' do
    find('#depot_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a beszállítandó anyagból', with: "wer"
    fill_in 'A bizonylat neve és száma, megjegyzés', with: "Szállító: 10"
    select "2014", from: 'depot[delivery(1i)]'
    select "április", from: 'depot[delivery(2i)]'
    select "1", from: 'depot[delivery(3i)]'
    click_button 'Anyag raktározása'
    expect(page).to have_content("hibát kérem javítson ki")
  end

  scenario 'negatív értékű mennyiség mezővel nem jön létre raktári sor' do
    find('#depot_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a beszállítandó anyagból', with: "-10"
    fill_in 'A bizonylat neve és száma, megjegyzés', with: "Szállító: 10"
    select "2014", from: 'depot[delivery(1i)]'
    select "április", from: 'depot[delivery(2i)]'
    select "1", from: 'depot[delivery(3i)]'
    click_button 'Anyag raktározása'
    expect(page).to have_content("hibát kérem javítson ki")
  end
end