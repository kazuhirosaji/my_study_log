class SubjectsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: :destroy

  def create
    @subject = current_user.subjects.build(subject_params)
    @user = current_user
    if @subject.save
      flash[:success] = "New Subject created!"
    else
      flash[:error] = 'Error: Invalid subject name'
    end
    redirect_to current_user
  end


  def destroy
    @subject.destroy
    redirect_to root_url
  end

  private

    def subject_params
      params.require(:subject).permit(:name)
    end

    def correct_user
      @subject = current_user.subjects.find_by(id: params[:id])
      redirect_to root_url if @subject.nil?
    end
end
