require 'spec_helper'

feature "A kapcsolat oldal megjelenése" do
  scenario "címe AK-Kapcsolat kell legyen" do
    visit '/contact'
    expect(page).to have_title('AK-Kapcsolat')
    expect(page).not_to have_title('AK - kapocs')
  end

  scenario "helyesen tartalmazza a Kapcsolat oldal elemeit" do
    visit '/contact'
    page.should have_selector('strong', text: 'Balogh István')
    page.should have_text('8412 Veszprém')
    page.should have_text('baloggo@gmail.com')
  end
end