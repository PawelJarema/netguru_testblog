class CommentsController < ApplicationController

  def new
  end

  def create
    comment = Comment.new(comment_params)
    comment.user = current_user
    comment.post = current_post

    if comment.save

    else

    end
    redirect_to comment.post
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
