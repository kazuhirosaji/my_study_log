module StaticPagesHelper
  def get_month_count(marks)
    results = {}
    marks.each do |mark|
      str = change_date_format(mark.date)
      if results[str]
        results[str] += 1
      else
        results[str] = 1
      end
    end
    results
  end
  
  def change_date_format(date)
    parts = []
    parts = date.split(" ")
    str = "#{parts[3]}/#{get_month(parts[1])}"
  end

  def get_month(m)
    months = [" ", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    months.find_index(m)
  end
end
