require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_content('My Studylog')}
    it { should have_title('My Studylog')}
  end

  describe "Statistics page" do
    let(:user) { FactoryGirl.create(:user) }
    before {
      sign_in user
      visit statistics_path
    }
    it { should have_content('Statistics page') }
    it { should have_content(user.name) }

    context "without subject" do
      it { should have_content("subjects count = 0")}
    end

    context "with subject" do
      before {
        subj = user.subjects.build(name: "programing")
        subj.save
        visit statistics_path
      }
      it {
        should have_content("subjects count = #{user.subjects.count}")
      }
    end
  end
end
