class Comment < ActiveRecord::Base
  belongs_to :post
  has_many :user_comment_ratings
  has_many :users, through: :user_comment_ratings
end
