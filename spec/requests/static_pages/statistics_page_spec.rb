require 'spec_helper'

def create_subjects(user, num)
  subj = []
  num.times do |i|
    subj[i] = user.subjects.build(name: "subject#{i}")
    subj[i].save
  end
  subj
end

def create_marks(subject, num, y=2014, m=6, d=4)
  mark = []
  day = Time.local(y, m, d, 0, 0, 0)

  num.times do |i|
    mark[i] = subject.marks.build(subject_id: subject.id, date: day.strftime("%a %b %d %Y %X %Z").to_s )
    mark[i].save
    day = day + 24*60*60
  end
  mark
end

describe "Statistics page" do
  subject { page }
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
    it {
      subject = create_subjects(user, 1)
      subject.each do |subj|
        create_marks(subj, 2)
      end
      visit statistics_path

      should have_content("subjects count = #{user.subjects.count}")
      should have_content("subject0 count = 2")
    }
    it {
      subject = create_subjects(user, 2)
      subject.each do |subj|
        create_marks(subj, 3)
      end
      visit statistics_path

      should have_content("subject0 count = 3")
      should have_content("subject1 count = 3")
    }
    it {
      subject = create_subjects(user, 10)
      i = 0
      subject.each do |subj|
        create_marks(subj, i)
        i += 1
      end
      visit statistics_path

      user.subjects.count.times do |i|
        should have_content("subject#{i} count = #{i}")
      end
    }
  end
  context "check each month's marks" do
    before {
      subject = create_subjects(user, 1)
      create_marks(subject[0], 3, 2014, 7, 1)
      create_marks(subject[0], 2, 2014, 8, 1)
      visit statistics_path
    }
    it { should have_content("subject0 count = 5") }
    it { should have_content("subject0 2014/7 count = 3") }
    # it { should have_content("subject0 2014/8 count = 2") }
  end
end
