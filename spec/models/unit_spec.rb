
require 'spec_helper'

describe User do

  before { @user = User.new(email: "felhasznalo@peldas.hu", password: "Jelszó23", password_confirmation: "Jelszó23") }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "nem valid, ha az email mező üres" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "ha az email formátum nem helyes" do
    it "nem valid" do
      cim = %w[megtudja poéta@költő]
      cim.each do |rosszcim|
        @user.email = rosszcim
        expect(@user).not_to be_valid
      end
    end
  end

  describe "ha az email formátum helyes" do
    it "valid" do
      cim = %w[user@foo.com SZERZO@EXAMPL.HU]
      cim.each do |jocim|
        @user.email = jocim
        expect(@user).to be_valid
      end
    end
  end

  describe "duplán nem szerepelhetnek email címek" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "jelszó kell a regisztrációhoz" do
    before do
      @user = User.new(email: "jo@cime.hu",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "nem vaild, ha nem egyformák a jelszavak" do
    before { @user.password_confirmation = "különböző" }
    it { should_not be_valid }
  end

  describe "nem vaild rövid jelszóval" do
    before { @user.password = @user.password_confirmation = "c" * 5 }
    it { should be_invalid }
  end
end
