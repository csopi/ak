require 'spec_helper'

describe Project do
  let(:user) { FactoryGirl.create(:user) }
  before { @project = Project.new(name: "Rázós projekt", description: "31485 Minimumfalva, Ötvenedik u. 43. --> felújítás", user_id: user.id) }

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:description) }

  it { should be_valid }

  describe "nem valid, ha a név mező üres" do
    before { @project.name = "" }
    it { should_not be_valid }
  end

  describe "duplán nem szerepelhetnek projekt nevek(azonos nevek)" do
    before do
      project_with_same_name = @project.dup
      project_with_same_name.save
    end

    it { should_not be_valid }
  end
end