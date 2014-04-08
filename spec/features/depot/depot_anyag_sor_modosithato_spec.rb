require 'spec_helper'

feature "Raktári sor módosítható" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:depot) do
      FactoryGirl.create(:depot)
  end

  let!(:depot_ketto) do
      FactoryGirl.create(:depot, id: 2, item_id: 1, user_id: 1, quantity: "60", pass: "számla: ui76", delivery: "2014-03-31")
  end

  let!(:unit) do
      FactoryGirl.create(:unit)
  end

  let!(:item) do
      FactoryGirl.create(:item)
  end

  let!(:item_ketto) do
      FactoryGirl.create(:item, id:2, name: "homok", unit_id: 1)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    click_link 'Raktár'
    first(:link, '38-as N+F tégla').click
  end

  scenario 'név módosítható' do
    find('#depot_item_id').find(:xpath, 'option[2]').select_option
    click_button 'Raktári anyag sor frissítése'
    expect(page).to have_content("homok 45.0 klts 2014-03-31 Szállítólevél: RT2365")
  end

  scenario 'mennyiség módosítható' do
    fill_in 'Mennyiség a beszállítandó anyagból', with: "1234"
    click_button 'Raktári anyag sor frissítése'
    expect(page).to have_content("38-as N+F tégla 1234.0 klts 2014-03-31 Szállítólevél: RT2365")
  end

  scenario 'a bizonylat mező módosítható' do
    fill_in 'A bizonylat neve és száma, megjegyzés', with: "Számla: 1234"
    click_button 'Raktári anyag sor frissítése'
    expect(page).to have_content("38-as N+F tégla 45.0 klts 2014-03-31 Számla: 1234")
  end

  scenario 'a beszállítás időpontja módosítható' do
    select "2014", from: 'depot[delivery(1i)]'
    select "április", from: 'depot[delivery(2i)]'
    select "1", from: 'depot[delivery(3i)]'
    click_button 'Raktári anyag sor frissítése'
    expect(page).to have_content("38-as N+F tégla 45.0 klts 2014-04-01 Szállítólevél: RT2365")
  end
end