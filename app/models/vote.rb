class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  before_save :check_if_abusive

  field :positive, type: Boolean, default: true

  belongs_to :comment
  belongs_to :user

  def check_if_abusive
    comment.set_abusive! true if positive == false and comment.bad_votes == 2
  end

end
