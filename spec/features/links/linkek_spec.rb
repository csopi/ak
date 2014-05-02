require 'spec_helper'

describe "A linkek" do
  it "helyesen működnek akkor amikor nincsen bejelentkezve a felhasználó" do
    visit root_path
    click_link "Az alkalmazásról"
    expect(page).to have_title('AK-Az alkalmazásról')
    click_link "Kapcsolat"
    expect(page).to have_title('AK-Kapcsolat')
    click_link "AnyagKövető"
    expect(page).to have_title('AnyagKövető')
    click_link "Bejelentkezés"
    expect(page).to have_title('AK-Bejelentkezés')
    click_link "Regisztráció"
    expect(page).to have_title('AK-Regisztráció')
    click_link "AnyagKövető"
    expect(page).to have_title('AnyagKövető')
  end

  it "helyesen működnek akkor is amikor bejelentkezett a felhasználó" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Bejelentkezés'
    fill_in 'A felhasználó email címe', with: user.email
    fill_in 'Jelszó', with: user.password
    click_button "Bejelentkezés"
    click_link "Az alkalmazásról"
    expect(page).to have_title('AK-Az alkalmazásról')
    click_link "Kapcsolat"
    expect(page).to have_title('AK-Kapcsolat')
    click_link "AnyagKövető"
    expect(page).to have_title('AnyagKövető')
    click_link "Raktár"
    expect(page).to have_title('AK-Raktár')
    click_link "Anyagok"
    expect(page).to have_title('AK-Anyagok')
    first(:link, 'Kimutatások').click
    first(:link, 'Az anyagok száma a rendszerben').click
    expect(page).to have_title('AK-Az anyagok száma')
    first(:link, 'Kimutatások').click
    first(:link, 'Raktári anyagok összesítése').click
    expect(page).to have_title('AK-Raktári anyagok')
    click_link "Összes projekt"
    expect(page).to have_title('AK-Projektek')
  end
end