require 'spec_helper'

feature "Az alkalmazásról oldal megjelenése" do
  scenario "címe AK-Az alkalmazásról kell legyen" do
    visit '/about'
    expect(page).to have_title('AK-Az alkalmazásról')
    expect(page).not_to have_title('AK - alka')
  end

  scenario "helyesen tartalmazza az Alkalmazásról oldal elemeit" do
    visit '/about'
    page.should have_selector('h3', text: 'Az alkalmazásról')
    page.should have_selector('h3', text: 'Használata')
  end
end