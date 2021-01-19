class User < ApplicationRecord
	validates :name, {presence: true}
	validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}
  
  has_many :browse_histories, dependent: :destroy
  has_many :regist_histories, dependent: :destroy
  def posts
    return Post.where(user_id: self.id)
  end
end
