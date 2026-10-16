class LikesController < ApplicationController
  before_action :require_login

  def create
    tweet = Tweet.find(params[:tweet_id])
    user = @current_user

    unless user.likes.exists?(tweet_id: tweet.id)
      user.like_tweets << tweet
    end

    redirect_to root_path, notice: "いいねしました。"
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique
    redirect_to root_path, alert: "いいねはすでに登録されています。"
  end

  def destroy
    tweet = Tweet.find(params[:id])
    user = @current_user

    tweet.likes.find_by(user_id: user.id)&.destroy!

    redirect_to root_path,
                notice: "いいねを削除しました。",
                status: :see_other
  end

  private

  def require_login
    @current_user = User.find_by(uid: session[:login_uid])

    unless @current_user
      redirect_to login_path, alert: "ログインしてください。"
    end
  end
end