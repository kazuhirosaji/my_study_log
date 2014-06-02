require 'spec_helper'

describe Subject do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @subject = Subject.new(name: "programing", user_id: user.id)
  end

  subject { @subject }
  
  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
end
