require 'spec_helper'

feature "Mértékegység" do
  let!(:user) do
      user = FactoryGirl.create(:user)
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
    visit '/units'
    click_link 'Új mértékegység'
  end

  scenario 'létrehozható' do
    fill_in 'A mértékegység neve', with: "példa"
    click_button 'Mértékegység létrehozása'
    expect(page).to have_content("A mértékegység sikeresen létrehozva.")
  end

  scenario 'üres név mezővel nem hozható létre' do
    fill_in 'A mértékegység neve', with: ""
    click_button 'Mértékegység létrehozása'
    expect(page).to have_content("A név nincs megadva")
  end

  scenario 'már foglalt név mezővel nem hozható létre' do
    fill_in 'A mértékegység neve', with: unit.name
    click_button 'Mértékegység létrehozása'
    expect(page).to have_content("A név már foglalt")
  end
end
