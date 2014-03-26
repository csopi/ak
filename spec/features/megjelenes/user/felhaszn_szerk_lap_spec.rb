require 'spec_helper'

feature "A felhasználó adatait szerkesztő lap" do
  let!(:user) do
    user = FactoryGirl.create(:user)
  end

  scenario "címe 'AK-Felh.szerkesztés' kell legyen" do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    click_link user.email + " bejelentkezve"
    expect(page).to have_title('AK-Felh.szerkesztés')
    expect(page).not_to have_title('AK - Valami')
  end

  scenario "helyesen tartalmazza a felhasználó adat szerkesztő oldal elemeit" do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    click_link user.email + " bejelentkezve"
    page.should have_selector('h3', text: user.email + ' adatainak szerkesztése')
    expect(page).to have_text('A felhasználó email címe')
    expect(page).to have_text('Jelszó (hagyja üresen, ha nem akarja megváltoztatni)')
    expect(page).to have_text('A jelszó még egyszer')
    expect(page).to have_text('A jelenlegi jelszó (a változtatások érvényesítéséhez)')
    expect(page).to have_button('Adatok frissítése')
    page.should have_selector('h5', text: 'A felhasználó törlése, jól gondolja meg')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_text('Felhasználó törlése')
    expect(page).to have_link('Kapcsolat')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
  end
end