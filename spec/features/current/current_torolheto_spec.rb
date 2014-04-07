require 'spec_helper'

feature "Beszállított anyag sor szerkeszthető" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:project) do
      FactoryGirl.create(:project)
  end

  let!(:project_ketto) do
      FactoryGirl.create(:project, name: "Második projektem", description: "8411 Veszprém-Kádárta, Fő u. 1. - fürdő felújítás", user_id: "1")
  end
  
  let!(:item) do
      FactoryGirl.create(:item)
  end

  let!(:unit) do
      FactoryGirl.create(:unit)
  end

  let!(:current) do
      FactoryGirl.create(:current)
  end

  let!(:current_ketto) do
      FactoryGirl.create(:current, id: 2, item_id: 1, project_id: 1, quantity: "60", pass: "számla: ui76")
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    first(:link, 'Első projektem').click
  end

  scenario 'törölhető' do
    first(:link, 'Sor törlése').click
    expect(page).to have_content("38-as N+F tégla 60.0 klts")
    expect(page).not_to have_content("38-as N+F tégla 45 klts")
  end
end