require 'spec_helper'

feature "A kezdőlap megjelenése" do
  scenario "címe AnyagKövető kell legyen" do
    visit '/'
    expect(page).to have_title('AnyagKövető')
    expect(page).not_to have_title('AK - segítség')
  end

  scenario "helyesen tartalmazza az AnyagKövető tartalmaz és a linkeket" do
    visit '/'
    page.should have_selector('h1', text: 'AnyagKövető')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    expect(page).to have_link('Bejelentkezés')
    expect(page).to have_link('Regisztráció')
  end
end