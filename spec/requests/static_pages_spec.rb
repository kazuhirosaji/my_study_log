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
    let(:time_info) {"00:00:00 GMT-0700 (PDT)"}

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
        mark = []
        mark[0] = subj.marks.build(subject_id: subj.id, date: "Wed Jun 04 2014 #{time_info}" )
        mark[1] = subj.marks.build(subject_id: subj.id, date: "Thu Jun 05 2014 #{time_info}" )
        mark.each do |mark|
          mark.save
        end
        visit statistics_path
      }
      it {
        should have_content("subjects count = #{user.subjects.count}")
        should have_content("marks count = 2")
      }
    end
  end
end
