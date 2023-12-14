class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # validations
  validates :name, presence: true, on: :update
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :update

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end

