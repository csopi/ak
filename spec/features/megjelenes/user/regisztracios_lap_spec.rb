require 'spec_helper'

feature "Regisztráció" do
  scenario "címe 'AK-Regisztráció' kell legyen" do
    visit '/'
    click_link 'Regisztráció'
    expect(page).to have_title('AK-Regisztráció')
    expect(page).not_to have_title('AK - Valami')
  end

  scenario "helyesen tartalmazza a Regisztrációs oldal elemeit" do
    visit '/'
    click_link 'Regisztráció'
    page.should have_selector('h3', text: 'Regisztráció')
    expect(page).to have_text('A felhasználó email címe')
    expect(page).to have_text('Jelszó')
    expect(page).to have_text('A jelszó még egyszer')
    expect(page).to have_button('Regisztráció')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    expect(page).to have_link('Bejelentkezés')
    expect(page).to have_link('Regisztráció')
  end
end