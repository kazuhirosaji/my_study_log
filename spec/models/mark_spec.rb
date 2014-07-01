require 'spec_helper'

describe Mark do
  let(:user) { FactoryGirl.create(:user) }
  let(:local_subject) do
    FactoryGirl.create(:subject, user: user)
  end
  before do
    @mark = local_subject.marks.build(date: "Wed Jun 04 2014 00:00:00 GMT-0700 (PDT)")
  end
  
  subject { @mark }
    
  it { should respond_to(:date) }
  it { should respond_to(:subject_id) }
  it { should respond_to(:subject) }
  its(:subject) { should eq local_subject }

  it { should be_valid }

  describe "when subject_id is not present" do
    before { @mark.subject_id = nil }
    it { should_not be_valid }
  end
  
end
