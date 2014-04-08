require 'spec_helper'

describe Depot do
  let(:user) { FactoryGirl.create(:user) }
  let(:item) { FactoryGirl.create(:item) }
  before { @depot = Depot.new(quantity: "10", pass: "Számla: 1234", delivery: "2014-04-05", user_id: user.id, item_id: item.id) }

  subject { @depot }

  it { should respond_to(:quantity) }
  it { should respond_to(:pass) }
  it { should respond_to(:delivery) }
  it { should respond_to(:user_id) }
  it { should respond_to(:item_id) }

  it { should be_valid }

  describe "nem valid, ha a mennyiség mező üres" do
    before { @depot.quantity = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a mennyiség mező 0" do
    before { @depot.quantity = "0" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a mennyiség mező negatív" do
    before { @depot.quantity = "-10" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a mennyiség mezőben nem szám szerepel" do
    before { @depot.quantity = "demo" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a bizonylat mező üres" do
    before { @depot.pass = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a dátum mező üres" do
    before { @depot.delivery = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha az anyag mező üres" do
    before { @depot.item_id  = "" }
    it { should_not be_valid }
  end

end