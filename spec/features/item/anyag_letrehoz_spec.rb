require 'spec_helper'

feature "Anyag" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:unit) do
      FactoryGirl.create(:unit)
  end

  let!(:item) do
      FactoryGirl.create(:item)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    visit '/items'
    click_link 'Új anyag'
  end

  scenario 'létrehozható' do
    fill_in 'Az anyag neve', with: "Áthidaló, A10-es, 1,25 m hosszú"
    all('#item_unit_id option')[1].select_option
    click_button 'Anyag létrehozása'
    expect(page).to have_content("Az anyag sikeresen létrehozva.")
  end

  scenario 'üres név mezővel nem hozható létre anyag' do
    fill_in 'Az anyag neve', with: ""
    all('#item_unit_id option')[1].select_option
    click_button 'Anyag létrehozása'
    expect(page).to have_content("A név nincs megadva")
  end

  scenario 'nem megfelelő mértékegység mezővel nem hozható létre anyag' do
    fill_in 'Az anyag neve', with: "Áthidaló, A10-es, 2 m-es"
    all('#item_unit_id option')[0].select_option
    click_button 'Anyag létrehozása'
    expect(page).to have_content("A mértékegység nincs megadva")
  end

  scenario 'már foglalt név mezővel nem hozható létre anyag' do
    fill_in 'Az anyag neve', with: item.name
    all('#item_unit_id option')[1].select_option
    click_button 'Anyag létrehozása'
    expect(page).to have_content("A név már foglalt")
  end
end