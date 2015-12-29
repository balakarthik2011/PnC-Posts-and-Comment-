json.array!(@ratings) do |rating|
  json.extract! rating, :id, :star, :post
  json.url rating_url(rating, format: :json)
end
