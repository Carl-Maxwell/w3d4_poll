class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_cant_be_author

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

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def respondent_has_not_already_answered_question
    if sibling_responses.where("responses.user_id = ?", user_id).exists?
      self.errors[:multiple_response_error] << "Respondant has already answered"
    end
  end

  def respondent_cant_be_author
    if question.poll.author.id == user_id
      self.errors[:author_answering_his_own_poll] <<
            "Author can't respond to own poll"
    end
  end


  def sibling_responses
    responses = question.responses
    unless self.id.nil?
      responses = responses.where("responses.id != ?", self.id)
    end
    responses
  end
end
