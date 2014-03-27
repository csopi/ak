require 'spec_helper'

feature "Mértékegység" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:unit) do
      FactoryGirl.create(:unit)
  end

  let!(:unit_ketto) do
      FactoryGirl.create(:unit, name: "egys")
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    visit '/units'
    first(:link, 'Mértékegység szerkesztése').click
  end

  scenario 'szerkeszthető' do
    fill_in 'A mértékegység neve', with: 'tonna'
    click_button 'Mértékegység frissítése'
    expect(page).to have_content("A mértékegység sikeresen szerkesztve.")
  end

  scenario 'a szerkesztés során üres név mezővel nem menthető' do
    fill_in 'A mértékegység neve', with: ''
    click_button 'Mértékegység frissítése'
    expect(page).to have_content("A név nincs megadva")
  end

  scenario 'a szerkesztés során már foglalt név mezővel nem menthető' do
    fill_in 'A mértékegység neve', with: unit_ketto.name
    click_button 'Mértékegység frissítése'
    expect(page).to have_content("A név már foglalt")
  end
end