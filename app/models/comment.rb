class Comment

  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false

  validates_presence_of :body

  belongs_to :user
  belongs_to :post
  has_many :votes

  def is_abusive?
    abusive
  end

  def set_abusive! boolean_flag
    update_attribute :abusive, boolean_flag
  end

  def good_votes
    votes.where(positive: true).length
  end

  def bad_votes
    votes.where(positive: false).length
  end

end
