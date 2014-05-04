class PostsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:posts) { Post.all }
  expose_decorated(:post, attributes: :post_params)
  expose(:tag_cloud) { tag_cloud }
  expose(:comments) { comments }
  expose(:comment) { new_comment }

  def index
  end

  def new
  end

  def edit
  end

  def update
    if post.save
      render action: :index
    else
      render :new
    end
  end

  def destroy
    post.destroy if current_user.owner? post
    render action: :index
  end

  def show
    set_current_post post.id
  end

  def mark_archived
    # post = Post.find params[:id]
    post.archive!
    render action: :index
  end

  def create
    post.user = current_user
    if post.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def new_comment
    Comment.new
  end

  def comments
    current_user.id == post.user.id ? post.comments : post.comments.where(abusive: false)
  end

  def tag_cloud
    tag_cloud = {}
    Post.all.each do |post|
      post.tags_array.each do |tag|
        unless tag_cloud.has_key? tag
          tag_cloud[tag] = 1
        else
          tag_cloud[tag] += 1
        end
      end
    end
    tag_cloud.sort
  end

  private

  def post_params
    return if %w{mark_archived}.include? action_name
    params.require(:post).permit(:body, :title, :tags)
  end
end
