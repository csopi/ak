require 'spec_helper'

feature "Projektek szerkesztése" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:project) do
      project = FactoryGirl.create(:project)
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    click_link 'Projekt név és leírás szerkesztése'
  end

  scenario "címe 'AK-Projekt szerkesztése' kell legyen" do
    expect(page).to have_title('AK-Projekt szerkesztése')
    expect(page).not_to have_title('AK - Ez+az')
  end

  scenario "helyesen tartalmazza a Projektek oldal elemeit" do
    expect(page).to have_link('Projektek')
    expect(page).to have_link(user.email + " bejelentkezve")
    expect(page).to have_link('Kijelentkezés')
    expect(page).to have_link('Az alkalmazásról')
    expect(page).to have_link('Kapcsolat')
    page.should have_selector('h3', text: 'Projekt szerkesztése')
    expect(page).to have_text('A projekt neve')
    expect(page).to have_text('A projekt adatai')
    expect(page).to have_field("project_name", :with => project.name)
    expect(page).to have_text(project.description)
    expect(page).to have_button('Projekt adatok frissítése')
  end
end