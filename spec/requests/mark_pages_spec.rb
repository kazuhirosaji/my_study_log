require 'spec_helper'

describe "Mark pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:local_subject) do
    FactoryGirl.create(:subject, user: user)
  end
  before { sign_in user }


  describe "mark save" do

    describe "with invalid information" do

      it "should not save a mark" do
        expect { click_button "Save Events" }.not_to change(Mark, :count)
      end

      describe "error messages" do
        before { click_button "Save Events" }
        it { should have_content('Error') }
      end
    end

    describe "with valid information" do

      before { 
        fill_in 'mark_date', with: "Wed Jun 04 2014 00:00:00 GMT-0700 (PDT)" 
        # select subject to english
      }
      it "should create a mark" do
        expect { click_button "Save Events" }.to change(Mark, :count).by(1)
      end
    end
  end
end

