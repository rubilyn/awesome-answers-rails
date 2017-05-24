class Answer < ApplicationRecord
  belongs_to :question

  # belongs_to :question expects that the answers table will have
  # a question_id reference column

  # Methods added by belongs_to :question to Answer model:
  # question
  # question=(associate)
  # build_question(attributes = {})
  # create_question(attributes = {})
  # create_question!(attributes = {})

  validates :body, presence: true
end
