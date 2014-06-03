require 'spec_helper'

describe Subject do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @subject = user.subjects.build(name: "programing")
  end

  subject { @subject }
  
  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  
  it { should be_valid }

  describe "when user_id is not present" do
    before { @subject.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank subject" do
    before { @subject.name = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @subject.name = "a" * 31 }
    it { should_not be_valid }
  end

end
