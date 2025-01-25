json.extract! submission, :id, :submission_type_id, :link, :created_at, :updated_at
json.url submission_url(submission, format: :json)
