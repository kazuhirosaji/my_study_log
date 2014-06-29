require 'spec_helper'

describe Mark do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @subject = user.subjects.build(name: "programing")
    @mark = @subject.marks.build(date: "Wed Jun 04 2014 00:00:00 GMT-0700 (PDT)")
  end
  
  subject { @mark }

  it { should respond_to(:date) }
  it { should respond_to(:subject_id) }
  it { should respond_to(:subject) }
  its(:subject) { should eq @subject }

  it { should be_valid }
  
end
