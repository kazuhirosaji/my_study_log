require 'spec_helper'

describe "Mark pages" do

  subject { page }
  @will_count_up = 0

  let(:user) { FactoryGirl.create(:user) }
  let(:time_info) {"00:00:00 GMT-0700 (PDT)"}

  share_examples_for 'Save button not create a mark' do
    it { expect { click_button "Save Events" }.not_to change(Mark, :count) }
  end

  share_examples_for 'Save button create mark' do
    it "should create #{@will_count_up} mark" do
      expect { click_button "Save Events" }.to change(Mark, :count).by(@will_count_up)
    end
  end

  context "save" do
    before do
      sign_in user
      @subject = user.subjects.build(name: "programing")
      @subject.save
    end

    context "with invalid information" do

      it_should_behave_like 'Save button not create a mark'

      context "invalid subject name" do
        before { 
          find("#mark_subjects").set("dummy name | Wed Jun 04 2014 #{time_info}")
        }
        it_should_behave_like 'Save button not create a mark'
      end
    end

    context "with valid information" do
      before { 
        find("#mark_subjects").set(@subject.name + " | Wed Jun 04 2014 #{time_info}")
      }
      @will_count_up = 1
      it_should_behave_like 'Save button create mark'
    end
    context "with 2 valid information" do
      before {
        other_subject = user.subjects.build(name: "english")
        other_subject.save
        find("#mark_subjects").set(@subject.name + "| Wed Jun 04 2014 #{time_info} ," + other_subject.name + "| Thu Jun 05 2014 #{time_info} ,")
      }
      @will_count_up = 2
      it_should_behave_like 'Save button create mark'
    end

    context "decrease mark" do
      before { 

        find("#mark_subjects").set(@subject.name + "| Wed Jun 04 2014 #{time_info} ," + @subject.name + " | Thu Jun 05 2014 #{time_info} ,")
        click_button "Save Events"
        find("#mark_subjects").set(@subject.name + "| Wed Jun 04 2014 #{time_info}")
      }
      @will_count_up = -1
      it_should_behave_like 'Save button create mark'
      
      context "decrease unused subjects.mark" do
        before { 
          click_button "Save Events"
          other_subject = user.subjects.build(name: "english")
          other_subject.save
          find("#mark_subjects").set(other_subject.name + "| Wed Jun 04 2014 #{time_info}")
        }
        it_should_behave_like 'Save button not create a mark'
      end
    end

    context "duplicate information" do
      before { 
        find("#mark_subjects").set(@subject.name + "| Wed Jun 04 2014 #{time_info} ," + @subject.name + " | Wed Jun 04 2014 #{time_info} ,")
      }
      @will_count_up = 1
      it_should_behave_like 'Save button create mark'
    end
  end

  context "load" do
    before do
      @subject = user.subjects.build(name: "programing")
      @subject.save
      @mark = []
      @mark[0] = @subject.marks.build(subject_id: @subject.id, date: "Wed Jun 04 2014 #{time_info}" )
      @mark[1] = @subject.marks.build(subject_id: @subject.id, date: "Thu Jun 05 2014 #{time_info}" )
      @mark.each do |mark|
        mark.save
      end
      sign_in user
    end
    it "should have saved Marks" do
      Mark.count.should == 2
    end
  end
end

