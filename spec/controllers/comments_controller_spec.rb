require 'spec_helper'

# I implemented vote handling in VotesController...
describe VotesController do


  let(:user) { create(:user) }
  let(:post1)  { create(:post, user: user) }
  let(:comment) { create(:comment, user: user, post: post1, abusive: true) }
  let(:user2) { create(:user) }

  before do
    request.env['warden'].stub authenticate!: user
    controller.stub current_user: user
    session[:active_post] = post1
  end


  describe "POST mark_as_not_abusive" do
    it "should change comment to not abusive" do
      post :mark_as_not_abusive, id: comment
      comment.reload.abusive.should be_false
    end
  end

  describe "POST vote_up" do
    before do
      request.env['warden'].stub authenticate!: user
      controller.stub current_user: user
      # session[:active_post] = post1
    end

    it "should create vote for the first time" do
      post :vote_up, id: comment
      comment.votes.count.should eq 1
    end

    it "should not create second vote for the same comment from this user" do
      expect {
        2.times { post :vote_up, id: comment }
        }.to change(comment.votes, :count).to(1)
    end
  end
end
