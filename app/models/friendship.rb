class Friendship < ApplicationRecord
  enum status: { pending: 0, confirmed: 1 }
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm_friend
    Friendship.confirmed!
    Friendship.create!(friend_id: user_id,
                       user_id: friend_id,
                       status: 'confirmed')
  end
end
