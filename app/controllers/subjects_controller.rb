class SubjectsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: :destroy

  def create
    @subject = current_user.subjects.build(subject_params)
    @user = current_user
    if @subject.save
      @message = 'New Subject created!'
    else
      @message = 'Error: Invalid subject name'
    end
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    @subject.destroy
    @delete_message = 'Delete subject'
    @user = current_user

    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
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
