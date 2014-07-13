require 'spec_helper'

def check_save_events_error
  before { click_button "Save Events" }
  it { should have_content('Error') }
end

describe "Mark pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
    @subject = user.subjects.build(name: "programing")
    @subject.save
  end

  describe "mark save" do

    describe "with invalid information" do

      it "should not save a mark" do
        expect { click_button "Save Events" }.not_to change(Mark, :count)
      end

      describe "error messages" do
        check_save_events_error
      end

      describe "invalid subject name" do
        before { 
          fill_in 'mark_date', with: "Wed Jun 04 2014 00:00:00 GMT-0700 (PDT)" 
          fill_in 'mark_subject_id', with: 0
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
        fill_in 'mark_date', with: "Wed Jun 04 2014 00:00:00 GMT-0700 (PDT)" 
        fill_in 'mark_subject_id', with: @subject.id
      }
      it "should create a mark" do
        expect { click_button "Save Events" }.to change(Mark, :count).by(1)
      end
    end
  end
end

