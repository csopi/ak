require 'spec_helper'

describe Unit do
  let(:unit) { FactoryGirl.create(:unit) }
  before { @unit = Unit.new(name: "m2") }

  subject { @unit }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "nem valid, ha a név mező üres" do
    before { @unit.name = "" }
    it { should_not be_valid }
  end

  describe "duplán nem szerepelhetnek mértékegység nevek" do
    before do
      unit_with_same_name = @unit.dup
      unit_with_same_name.save
    end

    it { should_not be_valid }
  end
end