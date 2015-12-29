json.array!(@posts) do |post|
  json.extract! post, :id, :name, :email, :message, :topic_id
  json.url post_url(post, format: :json)
end
