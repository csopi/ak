require 'spec_helper'

feature "Tervezett anyag sor létrehozható" do
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
    click_link 'Tervezett anyagfelhasználás'
    click_link 'Anyag hozzáadása'
  end

  scenario 'létrehozható' do
    find('#plan_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a tervezett anyagból', with: "4.44"
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("38-as N+F tégla : 4.44")
  end

  scenario 'a tervezett anyag sor mennyisége nő az új mennységgel ha az anyagot új mennyiséggel beírjuk' do
    find('#plan_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a tervezett anyagból', with: "4.44"
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("38-as N+F tégla : 4.44")
    click_link 'Anyag hozzáadása'
    find('#plan_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a tervezett anyagból', with: "5.55"
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("38-as N+F tégla : 9.99")
  end

  scenario 'üres mennyiség mezővel nem jön létre anyag sor' do
    find('#plan_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a tervezett anyagból', with: ""
    click_button 'Anyag sor létrehozása'
    expect(page).not_to have_content("38-as N+F tégla : 4.44")
  end

  scenario 'helytelenül kitöltött mennyiség mezővel nem jön létre anyag sor' do
    find('#plan_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a tervezett anyagból', with: "qwqe34"
    click_button 'Anyag sor létrehozása'
    expect(page).not_to have_content("Nem megfelelő adatot adott meg!")
  end

  scenario 'egyszer bevitt sor után üres mennyiség mezővel hibát jelez' do
    find('#plan_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a tervezett anyagból', with: "4.44"
    click_button 'Anyag sor létrehozása'
    click_link 'Anyag hozzáadása'
    find('#plan_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a tervezett anyagból', with: ""
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("Nem megfelelő adatot adott meg!")
  end

  scenario 'egyszer bevitt sor után szöveges mennyiség mezővel visszadob az anyagfelvitelhez' do
    find('#plan_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a tervezett anyagból', with: "4.44"
    click_button 'Anyag sor létrehozása'
    click_link 'Anyag hozzáadása'
    find('#plan_item_id').find(:xpath, 'option[1]').select_option
    fill_in 'Mennyiség a tervezett anyagból', with: "qwer"
    click_button 'Anyag sor létrehozása'
    expect(page).to have_content("38-as N+F tégla : 4.44")
  end
end