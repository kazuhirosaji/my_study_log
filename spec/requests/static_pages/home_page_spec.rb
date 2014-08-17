require 'spec_helper'

describe "Home page" do
  subject { page }

  before { visit root_path }
  it { should have_content('My Studylog')}
  it { should have_title('My Studylog')}
end

