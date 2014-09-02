require 'spec_helper'

describe "Subjects pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "subject creation" do

    describe "with invalid information" do

      it "should not create a subject" do
        expect { click_button "create" }.not_to change(Subject, :count)
      end
    end

    describe "with valid information" do

      before { fill_in 'subject_name', with: "report" }
      it "should create a subject" do
        expect { click_button "create" }.to change(Subject, :count).by(1)
      end
    end
  end

  describe "subject deletion" do
    before do
      @subject = user.subjects.build(name: "programing")
      @subject.save
      visit user_path(user)
    end
    it "should delete a subject" do
      expect {click_button "delete programing"}.to change(Subject, :count).by(-1)
    end
  end
end

