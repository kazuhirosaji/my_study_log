class MarksController < ApplicationController
  before_action :signed_in_user
# before_action :correct_user, only: :destroy

  def create
    events = []
    i = 0
    events = params[:mark_subjects].split(/\s*,\s*/)
    events.sort!

    error_message = ""
    current_name = ""
    subject = nil
    events.each do |event|
      name , date = event.split(/\s*\|\s*/)
      if name != current_name
        subject = current_user.subjects.find_by(name: name)
      end
      if subject
        subject.marks.create(date: date)
      else
        error_message += 'Error: Subject #{e[:n]} not found. '
      end
    end
    #subject.marks.where.not("date = 'Wed Jun 04 2014 00:00:00 GMT-0700 (PDT)'").delete_all
    error_message = "Error: Please input calendar events."  if events.size == 0

    if error_message == ""
      flash[:success] = 'Saved Calendar Info.'
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

