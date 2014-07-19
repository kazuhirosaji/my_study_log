class MarksController < ApplicationController
  before_action :signed_in_user
# before_action :correct_user, only: :destroy

  def create
    @subject = current_user.subjects.find_by(name: params[:mark_subject_name])
    if @subject
      @mark = @subject.marks.build(mark_params)
      @user = current_user
      if @mark.save
        flash[:success] = 'Saved Calendar Info'
      else
        flash[:error] = 'Error: Invalid Calendar Info'
      end
    else
      flash[:error] = 'Error: Subject not found'
    end
    redirect_to current_user
  end


  def destroy
    @subject.destroy
    redirect_to root_url
  end

  private

    def mark_params
      params.require(:mark).permit(:date, :subject_id)
    end

end

