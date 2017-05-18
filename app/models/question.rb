# Rails will connect this model to a table named `questions` by default as it
# uses the pluralized version of the class name.
# Also, Rails will give you attribute accessor to all the columns of the table.
class Question < ApplicationRecord

  validates(:title, { presence: { message: 'must be provided' },
                      uniqueness: true })
  validates(:body, { length: { minimum: 5, maximum: 1000 }})
  validates :view_count, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :set_defaults
  before_validation :titleize_title

  # scope :recent, lambda {|number| order(created_at: :desc).limit(number) }
  def self.recent(number)
    order(created_at: :desc).limit(number)
  end

  def cap_title
    title.upcase
  end

  private

  def set_defaults
    self.view_count ||= 0
  end

  def titleize_title
    self.title = title.titleize if title.present?
  end

end
