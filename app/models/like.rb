class Like < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # the following validation guarantees that a user can only like
  # a question once
  validates :question_id, uniqueness: {
    scope: :user_id,
    message: 'has already been liked by yourself' }
end
