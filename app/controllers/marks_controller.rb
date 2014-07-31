class MarksController < ApplicationController
  before_action :signed_in_user
# before_action :correct_user, only: :destroy

  def create
    events, @save_dates, @save_ids = [], [], []
    events = params[:mark_subjects].split(/\s*,\s*/)
    events.sort!

    @error_message = ""
    current_name = ""
    subject = nil

    @error_message = "Error: Please input calendar events."  if events.size == 0

    events.each do |event|
      name , date = event.split(/\s*\|\s*/)
      if name != current_name
        current_name = name
        delete_unsaved_marks(subject)
        subject = get_subject_by_name(name)
      end

      if subject
        create_mark(subject, date)
      end
    end

    delete_unsaved_marks(subject)
    current_user.subjects.where.not(id: @save_ids).each do |sbj|
      sbj.marks.delete_all
    end

    flash_message

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

    def flash_message
      if @error_message == ""
        flash[:success] = 'Saved Calendar Info.'
      else
        flash[:error] = @error_message
      end    
    end
    
    def get_subject_by_name(name)
        subject = current_user.subjects.find_by(name: name)
        if subject
          @save_ids << subject.id
        else
          @error_message += 'Error: Subject #{name} not found. '
        end
        subject
    end

    def create_mark(subject, date)
      subject.marks.create(date: date)
      @save_dates << date
    end

    def delete_unsaved_marks(subject)
      if subject != nil && @save_dates.length > 0
        subject.marks.where.not(date: @save_dates).delete_all
        @save_dates = []
      end
    end


end

