require 'spec_helper'

describe Plan do
  let(:plan) { FactoryGirl.create(:plan) }
  before { @plan = Plan.new(item_id: "1", project_id: "1", quantity: "4.78") }
  
  subject { @plan }

  it { should respond_to(:project_id) }
  it { should respond_to(:item_id) }
  it { should respond_to(:quantity) }

  it { should be_valid }

  describe "nem valid, ha az item_id üres" do
    before { @plan.item_id = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a quantity üres" do
    before { @plan.quantity = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha csak a project_id mező van kitöltve" do
    before { @plan.project_id = "1" }
    before { @plan.item_id = "" }
    before { @plan.quantity = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha csak az item_id mező van kitöltve" do
    before { @plan.project_id = "" }
    before { @plan.item_id = "1" }
    before { @plan.quantity = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha csak a quantity mező van kitöltve" do
    before { @plan.project_id = "" }
    before { @plan.item_id = "" }
    before { @plan.quantity = "4.5" }
    it { should_not be_valid }
  end

end