class SubjectsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: :destroy

  def create
    @subject = current_user.subjects.build(subject_params)
    if @subject.save
      flash[:success] = "New Subject created!"
      redirect_to root_url
    else
      flash.now[:error] = 'error. Invalid subject name'
      render 'static_pages/home'
    end
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
