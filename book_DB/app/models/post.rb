class Post < ApplicationRecord
  validates :user_id, {presence: true}

  has_many :browse_histories, dependent: :destroy
  has_many :regist_histories, dependent: :destroy
  
  def user
  	return User.find_by(id: self.user_id)
  end
end
