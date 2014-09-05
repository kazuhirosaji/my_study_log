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

  describe "delete subject" do
    before do
      programing = user.subjects.build(name: "programing")
      programing.save
      visit user_path(user)
    end
    it "should delete a subject" do
      expect {click_button "delete programing"}.to change(Subject, :count).by(-1)
    end
  end

  describe "delete 2subjects" do
    before do
      programing = user.subjects.build(name: "programing")
      english = user.subjects.build(name: "english") 
      programing.save
      english.save
      visit user_path(user)
    end
    it "should delete 2 subjects" do
      expect {click_button "delete programing"}.to change(Subject, :count).by(-1)
      expect {click_button "delete english"}.to change(Subject, :count).by(-1)
    end
  end

end

