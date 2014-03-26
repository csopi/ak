require 'spec_helper'

feature "Projekt" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:project) do
      FactoryGirl.create(:project)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    click_link 'Új projekt'
  end

  scenario 'létrehozható' do
    fill_in 'A projekt neve', with: "Példa projekt"
    fill_in 'A projekt adatai', with: "687985 Bélapátvölgye, centrális utca 32. --> kis ház felújítás"
    click_button 'Projekt létrehozása'
    expect(page).to have_content("A projekt sikeresen létrehozva.")
  end

  scenario 'üres név mezővel nem hozható létre' do
    fill_in 'A projekt neve', with: ""
    fill_in 'A projekt adatai', with: "687985 Bélapátvölgye, centrális utca 32. --> kis ház felújítás"
    click_button 'Projekt létrehozása'
    expect(page).to have_content("A név nincs megadva")
  end

  scenario 'már foglalt név mezővel nem hozható létre' do
    fill_in 'A projekt neve', with: project.name
    click_button 'Projekt létrehozása'
    expect(page).to have_content("A név már foglalt")
  end
end