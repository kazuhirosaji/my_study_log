class MarksController < ApplicationController
  before_action :signed_in_user
# before_action :correct_user, only: :destroy

  def create
    @mark = @subject.build(mark_params)
    @user = current_user
    if @mark.save
      flash[:success] = "Saved Calendar Marks"
    else
      flash[:error] = 'Error: Calendar Marks is nil'
    end
    red1irect_to current_user
  end


  def destroy
    @subject.destroy
    redirect_to root_url
  end

  private

end

