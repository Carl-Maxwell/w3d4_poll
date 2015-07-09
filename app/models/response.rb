class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondant,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def respondent_has_not_already_answered_question

    p AnswerChoice.find(answer_choice_id).question
    return

    question = AnswerChoice.find(answer_choice_id).question
    unless
      self.error[:multiple_response_error] <<
        "User has already answered this question"
    end
  end
end
