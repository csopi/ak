require 'spec_helper'

describe Item do
  let(:item) { FactoryGirl.create(:item) }
  before { @item = Item.new(name: "Járólap, 40 x 40 cm, GRES", unit_id: "1") }

  subject { @item }

  it { should respond_to(:name) }
  it { should respond_to(:unit_id) }

  it { should be_valid }

  describe "nem valid, ha a név mező üres" do
    before { @item.name = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha a mértékegység mező üres" do
    before { @item.unit_id = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha csak a név mező van kitöltve" do
    before { @item.name = "Betonacél szálban, 12 mm" }
    before { @item.unit_id = "" }
    it { should_not be_valid }
  end

  describe "nem valid, ha csak a mértékegység mező van kitöltve" do
    before { @item.name = "" }
    before { @item.unit_id = "tonna" }
    it { should_not be_valid }
  end

  describe "duplán nem szerepelhetnek anyag nevek" do
    before do
      item_with_same_name = @item.dup
      item_with_same_name.save
    end

    it { should_not be_valid }
  end
end