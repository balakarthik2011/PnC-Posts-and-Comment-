class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments
  has_many :ratings
  belongs_to :user

  #scope :recent, -> {where :user_id = 3)}

  scope :t , ->(from) { where("posts.created_at > ?", from) }
  scope :f , ->(from) { where("posts.created_at < ?", from) }
  #scope :created_before, ->(time) { where("created_at < ?", time) }

  has_and_belongs_to_many :users , join_table: :posts_users_read_status
  has_and_belongs_to_many :tags

  has_attached_file :image


  validates_presence_of :name, :presence => true,message: "Name should not be blank"
  validates_length_of :name,:maximum => 20,message: "Maximum 20 characters are allowed"
  validates_attachment :image,
                       content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
                       size:         { less_than: 1.megabytes }, message:"upload image less than 1MB"


end
