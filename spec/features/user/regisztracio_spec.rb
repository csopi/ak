require "spec_helper"

feature "Regisztráció" do
  scenario "új felhasználók bejelentkezhetnek" do
    visit "/"
    click_link "Regisztráció"

    fill_in "A felhasználó email címe", :with => "gyumolcs@level.hu"
    fill_in "Jelszó", :with => "valójában"
    fill_in "A jelszó még egyszer", :with => "valójában"

    click_button "Regisztráció"

    page.should have_content("Sikeres regisztráció.")
  end

  scenario "ha nem töltünk ki egy mezőt sem, akkor az alábbi hiba üzeneteket kapjuk" do
    visit '/'
    click_link 'Regisztráció'
    click_button "Regisztráció"
    expect(page).to have_content("Email nincs megadva")
    expect(page).to have_content("A jelszó nincs megadva")
  end
  
  scenario "ha csak a név mezőt töltjük ki, akkor az alábbi hiba üzeneteket kapjuk" do
    visit '/'
    click_link 'Regisztráció'
    fill_in "A felhasználó email címe", with: "Amanda"
    click_button "Regisztráció"
    expect(page).to have_content("A jelszó nincs megadva")
  end
  
  scenario "ha a név és a jelszó mezőket töltjük ki, akkor az alábbi hiba üzeneteket kapjuk" do
    visit '/'
    click_link 'Regisztráció'
    fill_in "A felhasználó email címe", with: "Amanda"
    fill_in "Jelszó", with: "azért"
    click_button "Regisztráció"
    expect(page).to have_content("A jelszó ismétlő nem egyezik")
  end
  
  scenario "ha a jelszó ellenörző nem egyezik a jelszóval, akkor az alábbi hiba üzeneteket kapjuk" do
    visit '/'
    click_link 'Regisztráció'
    fill_in "A felhasználó email címe", with: "Amanda"
    fill_in "Jelszó", with: "azért"
    fill_in "A jelszó még egyszer", with: "repter"
    click_button "Regisztráció"
    expect(page).to have_content("A jelszó ismétlő nem egyezik")
  end
  
  scenario "ha egy felhasználó email cím már regisztrált (foglalt), akkor az alábbi hiba üzeneteket kapjuk" do
    u = User.create(email: "roml@hu.lu", password: "jelszó45", password_confirmation: "jelszó45")
    visit '/'
    click_link 'Regisztráció'
    fill_in "A felhasználó email címe", with: "roml@hu.lu"
    fill_in "Jelszó", with: "számok345"
    fill_in "A jelszó még egyszer", with: "számok345"
    click_button "Regisztráció"
    expect(page).to have_content("Email már foglalt")
  end
end