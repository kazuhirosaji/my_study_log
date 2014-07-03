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

  describe "when subject name is alerady taken" do
    before do
      subject_with_same_name = @subject.dup
      subject_with_same_name.save
    end
    it { should_not be_valid }
  end

  describe "when one user have same subject names" do
    before do
      subject_with_same_name = user.subjects.build(name: @subject.name)
      subject_with_same_name.save
    end
    it { should_not be_valid }
  end

  describe "when two user have same subject names" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      subject_with_same_name = other_user.subjects.build(name: @subject.name)
      subject_with_same_name.save
    end
    it { should be_valid }
  end

end
