require 'spec_helper'

describe Subject do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @subject = Subject.new(name: "programing", user_id: user.id)
  end

  subject { @subject }
  
  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  
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
