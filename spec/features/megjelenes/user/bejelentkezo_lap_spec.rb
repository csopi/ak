require 'spec_helper'

feature "Bejelentkezés" do
  scenario "címe 'AK-Bejelentkezés' kell legyen" do
    visit '/'
    click_link 'Bejelentkezés'
    expect(page).to have_title('AK-Bejelentkezés')
    expect(page).not_to have_title('AK - Valami')
  end

  scenario "helyesen tartalmazza a Bejelentkező oldal elemeit" do
    visit '/'
    click_link 'Bejelentkezés'
    page.should have_selector('h3', text: 'Bejelentkezés')
    expect(page).to have_text('A felhasználó email címe')
    expect(page).to have_text('Jelszó')
    expect(page).to have_text('Maradjon bejelentkezve')
    expect(page).not_to have_text('A jelszó még egyszer')
    expect(page).to have_button('Bejelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    expect(page).to have_link('Bejelentkezés')
    expect(page).to have_link('Regisztráció')
  end
end