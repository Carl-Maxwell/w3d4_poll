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

  def results
    Question.find_by_sql([<<-SQL, self.id])
      SELECT
        answer_choices.*, COUNT(responses.*) AS num_responses
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses ON answer_choices.id = responses.answer_choice_id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id
    SQL
  end
end
