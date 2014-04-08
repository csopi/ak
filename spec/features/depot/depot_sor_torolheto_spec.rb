require 'spec_helper'

feature "Raktári sor szerkeszthető" do
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
  end

  scenario 'törölhető' do
    first(:link, 'Sor törlése').click
    expect(page).to have_content("38-as N+F tégla 60.0 klts")
    expect(page).not_to have_content("38-as N+F tégla 45 klts")
  end
end