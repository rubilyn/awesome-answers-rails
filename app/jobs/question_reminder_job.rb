class QuestionReminderJob < ApplicationJob
  queue_as :default

  # we can now run this job as such:
  # QuestionReminderJob.perform_now(1100) # this will run in the foreground
  # QuestionReminderJob.perform_later(1100) # this will run in the background
  def perform(question_id)
    question = Question.find question_id
    if question.answers.count == 0
      QuestionsMailer.send_reminder(question).deliver_now
    end
  end
end

#
# class QuestionReminderJob < ApplicationJob
#   queue_as :default
#
#   def perform(question_id)
#     question = Question.find question_id
#     if question.answers.count == 0
#
#     end
#   end
# end
