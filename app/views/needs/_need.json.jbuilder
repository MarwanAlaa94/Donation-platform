json.extract! need, :id, :title, :description, :start_date, :end_date, :in_progress, :money, :urgent_rate, :achievment_flag, :created_at, :updated_at
json.url need_url(need, format: :json)