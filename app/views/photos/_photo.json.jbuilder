json.extract! photo, :id, :title, :description, :price, :image_url, :created_at, :updated_at
json.url photo_url(photo, format: :json)
