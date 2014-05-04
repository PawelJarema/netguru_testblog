class VotesController < ApplicationController

  def vote_up
    vote = new_vote
    vote.positive = true
    vote.save unless current_user.voted? Comment.find(get_id)
    redirect_to vote.comment.post
  end

  def vote_down
    vote = new_vote
    comment = Comment.find(get_id)
    vote.positive = false
    vote.save unless current_user.voted? comment
    # comment.set_abusive! true if comment.bad_votes == 3 ..this logic is in Vote model now
    redirect_to comment.post
  end

  def mark_as_not_abusive
    comment = Comment.find(get_id)
    comment.set_abusive! false
    redirect_to comment.post
  end

  private

  def new_vote
    vote = Vote.new
    vote.user = current_user
    vote.comment = Comment.find(get_id)
    vote
  end

  def get_id
    BSON::ObjectId.from_string(params[:id])
  end

end
