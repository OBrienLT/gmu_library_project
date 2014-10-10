json.array!(@authors) do |author|
  json.extract! author, :id, :name, :dob, :nationality, :awards, :biography, :image_url
  json.url author_url(author, format: :json)
end
