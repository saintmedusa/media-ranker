class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  def joined_date
    return format_datetime(self.created_at)
  end
  def format_datetime(datetime)
    datetime_string = datetime.to_s
    time_array = datetime_string.split(/\D/)
    time_array = time_array.map {|e| e.to_i }
    time = Time.new(*time_array)
    formatted_time_string = time.strftime("%D")#("%a, %D at %r")
    return formatted_time_string
  end
end
