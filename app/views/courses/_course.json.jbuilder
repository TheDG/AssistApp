json.extract! course, :id, :teacher, :subject, :grade, :level, :created_at, :updated_at
json.url course_url(course, format: :json)
