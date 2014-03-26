require 'spec_helper'

feature "Felhasználó szerkesztése" do
  let!(:user) do
    user = FactoryGirl.create(:user)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    click_link user.email + " bejelentkezve"
  end

  scenario " lehetséges" do
    fill_in "A felhasználó email címe", with: "hillarycoller@be.edu.hu"
    fill_in "A jelenlegi jelszó (a változtatások érvényesítéséhez)", with: user.password
    click_button "Adatok frissítése"
    expect(page).to have_content("Sikeres fiók módosítás.")
  end

  scenario " jelszó módosítás lehetséges" do
    fill_in "Jelszó (hagyja üresen, ha nem akarja megváltoztatni)", with: "kepviselo"
    fill_in "A jelszó még egyszer", with: "kepviselo"
    fill_in "A jelenlegi jelszó (a változtatások érvényesítéséhez)", with: user.password
    click_button "Adatok frissítése"
    expect(page).to have_content("Sikeres fiók módosítás.")
  end

  scenario " a jelenlegi jelszó megadása nélkül (üres mező) nem lehetséges" do
    fill_in "A felhasználó email címe", with: user.email
    fill_in "A jelenlegi jelszó (a változtatások érvényesítéséhez)", with: ""
    click_button "Adatok frissítése"
    expect(page).to have_content("A jelenlegi jelszó nincs megadva")
  end

  scenario " rossz jelenlegi jelszó megadásával nem lehetséges" do
    fill_in "A felhasználó email címe", with: user.email
    fill_in "A jelenlegi jelszó (a változtatások érvényesítéséhez)", with: "tikitaka"
    click_button "Adatok frissítése"
    expect(page).to have_content("A jelenlegi jelszó nem megfelelő")
  end

  scenario "törölhető" do
    click_link "Felhasználó törlése"
    expect(page).to have_content("Felhasználói fiók törölve. Reméljük, még visszatér hozzánk.")
  end
end