require 'spec_helper'

def check_save_events_error
  before { click_button "Save Events" }
  it { should have_content('Error') }
end

describe "Mark pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:time_info) {"00:00:00 GMT-0700 (PDT)"}

  describe "mark save" do
    before do
      sign_in user
      @subject = user.subjects.build(name: "programing")
      @subject.save
    end

    describe "with invalid information" do

      it "should not save a mark" do
        expect { click_button "Save Events" }.not_to change(Mark, :count)
      end

      describe "error messages" do
        check_save_events_error
      end

      describe "invalid subject name" do
        before { 
          fill_in 'mark_date', with: "Wed Jun 04 2014 #{time_info}" 
          fill_in 'mark_subject_name', with: "dummy name"
        }
        it "should not create a mark" do
          expect { click_button "Save Events" }.not_to change(Mark, :count)
        end

        describe "error messages" do
          check_save_events_error
        end
      end
    end

    describe "with valid information" do
      before { 
        fill_in 'mark_date', with: "Wed Jun 04 2014 #{time_info}" 
        fill_in 'mark_subject_name', with: @subject.name
      }
      it "should create a mark" do
        expect { click_button "Save Events" }.to change(Mark, :count).by(1)
      end
    end
    describe "with 2 valid information" do
      before { 
        other_subject = user.subjects.build(name: "english")
        other_subject.save
        fill_in 'mark_date', with: "Wed Jun 04 2014 #{time_info} , Thu Jun 05 2014 #{time_info}" 
        fill_in 'mark_subject_name', with: @subject.name + " , " + other_subject.name
      }
      it "should create a mark" do
        expect { click_button "Save Events" }.to change(Mark, :count).by(2)
      end
    end
  end

  describe "mark load" do
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
    it { should have_content(@subject.name) }
    it { should have_content(@mark[0].date) }
    it { should have_content(@mark[1].date) }
  end
end

