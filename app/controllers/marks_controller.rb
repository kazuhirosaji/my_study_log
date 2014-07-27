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
    ids = []
    dates = []

    events.each do |event|
      name , date = event.split(/\s*\|\s*/)
      if name != current_name
        current_name = name
        if dates.length > 0
          subject.marks.where.not(date: dates).delete_all
          dates = []
        end
        subject = current_user.subjects.find_by(name: name)
      end
      dates << date
      if subject
        subject.marks.create(date: date)
        ids << subject.id
      else
        error_message += 'Error: Subject #{e[:n]} not found. '
      end
    end
    if subject != nil && dates.length > 0
      subject.marks.where.not(date: dates).delete_all
      dates = []
    end

    current_user.subjects.where.not(id: ids).delete_all
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

