class MarksController < ApplicationController
  before_action :signed_in_user
# before_action :correct_user, only: :destroy

  def create
    names, dates = []
    i = 0
    names = params[:mark_subject_name].split(/\s*,\s*/)
    dates = params[:mark][:date].split(/\s*,\s*/)
    error_message = ""
    names.each do |name|
      subject = current_user.subjects.find_by(name: name)
      if subject
        subject.marks.create(date: dates[i])
      else
        error_message += 'Error: Subject #{name} not found. '
      end
      i += 1
    end
    error_message = "Error: Please input calendar events"  if names.size == 0

    if error_message == ""
      flash[:success] = 'Saved Calendar Info'
    else
      flash[:error] = error_message
    end
    redirect_to current_user
  end


  def destroy
    @subject.destroy
    redirect_to root_url
  end

  private

    def mark_params
      params.require(:mark).permit(:date)
    end

end

