require 'spec_helper'

feature "Projekt törlése" do
  let!(:user) do
      user = FactoryGirl.create(:user)
  end

  let!(:project) do
      FactoryGirl.create(:project)
  end

  let!(:project_ketto) do
      FactoryGirl.create(:project, name: "Második projektem")
  end

  before(:each) do
    visit '/'
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
  end

    scenario "törölhető" do
    first(:link, 'Projekt törlése').click
    expect(page).to have_content("A projekt törölve.")
    expect(page).to have_content(project_ketto.name)
    expect(page).not_to have_content(project.name)
  end
end