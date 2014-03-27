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

  let!(:item_ketto) do
      FactoryGirl.create(:item, name: "Parketta, tölgy", unit_id: "1")
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    visit '/items'
  end

  scenario 'törölhető' do
    first(:link, 'Anyag törlése').click
    expect(page).to have_content("Az anyag törölve.")
    expect(page).to have_content(item_ketto.name)
    expect(page).not_to have_content(item.name)
  end
end