class Question < ActiveRecord::Base
  validates :question, presence: true
  validates :poll_id, presence: true

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def second_result
    question_results = {}

    answer_choices.includes(:responses).each do |answer|
      question_results[answer.choice] = answer.responses.length
    end

    question_results
  end

  def first_results
    question_results = {}

    answer_choices.each do |answer|
      question_results[answer.choice] = answer.responses.count
    end

    question_results
  end
end
