class MarksController < ApplicationController
  before_action :signed_in_user
# before_action :correct_user, only: :destroy

  def create
    events, @save_dates, @save_ids = [], [], []
    events = params[:mark_subjects].split(/\s*,\s*/)
    events.sort!

    @error_message = ""
    @save_message = nil
    current_name = ""
    subject = nil


    if  events.size == 0
      @error_message = "Error: not changed"
      set_message
      respond_to do |format|
        format.html { redirect_to current_user }
        format.js
      end
      return
    end

    events.each do |event|
      name , date = event.split(/\s*\|\s*/)
      if name != current_name
        current_name = name
        delete_unsaved_date_marks(subject)
        subject = get_subject_by_name(name)
      end

      if subject
        create_mark(subject, date)
      end
    end

    delete_unsaved_date_marks(subject)
    delete_unsaved_subject_marks(current_user)

    set_message

    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end


  def destroy
    @subject.destroy
    redirect_to root_url
  end

  private

    def mark_params
      params.require(:mark).permit(:date)
    end

    def set_message
      if @error_message == ""
        @save_message = 'Saved Calendar Info.'
      else
        @save_message = @error_message
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

    def delete_unsaved_date_marks(subject)
      if subject != nil && @save_dates.length > 0
        subject.marks.where.not(date: @save_dates).delete_all
        @save_dates = []
      end
    end

    def delete_unsaved_subject_marks(user)
      user.subjects.where.not(id: @save_ids).each do |sbj|
        sbj.marks.delete_all
      end
    end

end

