require 'spec_helper'

describe Current do
  let(:current) { FactoryGirl.create(:current) }
  before { @current = Current.new(item_id: "1", project_id: "1", quantity: "54", pass: "Számla: ED645324", delivery: "2014-04-07") }
  
  subject { @current }

  it { should respond_to(:project_id) }
  it { should respond_to(:item_id) }
  it { should respond_to(:quantity) }
  it { should respond_to(:pass) }
  it { should respond_to(:delivery) }

  it { should be_valid }

  describe "nem valid, ha az item_id üres" do
    before { @current.item_id = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a quantity üres" do
    before { @current.quantity = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a pass üres" do
    before { @current.pass = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a delivery üres" do
    before { @current.delivery = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha csak a project_id mező van kitöltve" do
    before { @current.project_id = "1" }
    before { @current.item_id = "" }
    before { @current.quantity = "" }
    before { @current.pass = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha csak az item_id mező van kitöltve" do
    before { @current.project_id = "" }
    before { @current.item_id = "1" }
    before { @current.quantity = "" }
    before { @current.pass = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha csak a quantity mező van kitöltve" do
    before { @current.project_id = "" }
    before { @current.item_id = "" }
    before { @current.quantity = "4.5" }
    before { @current.pass = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha csak a pass mező van kitöltve" do
    before { @current.project_id = "" }
    before { @current.item_id = "" }
    before { @current.quantity = "" }
    before { @current.pass = "Számla: WE12978" }
    it { should_not be_valid }
  end

end