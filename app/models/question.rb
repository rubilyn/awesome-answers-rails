# Rails will connect this model to a table named `questions` by default as it
# uses the pluralized version of the class name.
# Also, Rails will give you attribute accessor to all the columns of the table.
class Question < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  # by default belongs_to adds a validation to verify that
  # the association exists
  # validates :category_id, presence: true

  # It's highly recommend that you add the `dependent` option to
  # the association which tells Rails what to do when you delete a
  # Question that has answers associated to it, the most popular options
  # are:
  # - `:destroy` which will delete all associated answers before deleting
  #   the question
  # - `:nullify` which will update all the `question_id` fields on the associated
  #   to be `NULL` before deleting the question
  has_many :answers , dependent: :destroy

  # has_many :answers expects that the answers table will have a
  # question_id reference column

  # has_many :answers method adds the following methods to Questions:
  # answers
  # answers<<(object, ...)
  # answers.delete(object, ...)
  # answers.destroy(object, ...)
  # answers=(objects)
  # answers_singular_ids
  # answers_singular_ids=(ids)
  # answers.clear
  # answers.empty?
  # answers.size
  # answers.find(...)
  # answers.where(...)
  # answers.exists?(...)
  # answers.build(attributes = {}, ...)
  # answers.create(attributes = {})
  # answers.create!(attributes = {})

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  has_many :taggings, dependent: :destroy
  # we don't have to give has_many a source when the name of
  # of the relationship is the same as the source
  has_many :tags, through: :taggings

  validates(:title, { presence: { message: 'must be provided' },
                      uniqueness: true })
  validates(:body, { length: { minimum: 5, maximum: 1000 }})
  validates :view_count, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :set_defaults
  before_validation :titleize_title

   mount_uploader :image, ImageUploader

  # scope :recent, lambda {|number| order(created_at: :desc).limit(number) }
  def self.recent(number)
    order(created_at: :desc).limit(number)
  end

  def cap_title
    title.upcase
  end

  def vote_total
    votes.up.count - votes.down.count
  end

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders, :history]

  # this method gets used by Rails when generating URLs using Rails helpers. For
  # instance when you put something like: question_path(@question)
  # then Rails will generate a url like: /questions/:id. Rails will use the
  # to_param method to replace the `:id` part of the URL. By default all
  # ActiveRecord model return `id` from the `to_param` method
  # def to_param
  #   "#{id}-#{title}".parameterize
  # end

  private

  def set_defaults
    self.view_count ||= 0
  end

  def titleize_title
    self.title = title.titleize if title.present?
  end

end
