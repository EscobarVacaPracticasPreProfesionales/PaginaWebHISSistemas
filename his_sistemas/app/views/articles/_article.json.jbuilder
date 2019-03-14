json.extract! article, :id, :title, :description, :content, :pictures, :figcaption, :fecha, :user_id, :created_at, :updated_at
json.url article_url(article, format: :json)
