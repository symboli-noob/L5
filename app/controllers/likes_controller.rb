class LikesController < ApplicationController
  before_action :require_login

  def create
    tweet = Tweet.find(params[:tweet_id])

    # いいねしていなければ追加
    unless tweet.liked?(current_user)
      tweet.like(current_user)
    end

    redirect_to root_path, notice: "いいねしました。"
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique
    redirect_to root_path, alert: "いいねはすでに登録されています。"
  end

  def destroy
    tweet = Tweet.find(params[:id])

    # いいねしていれば解除
    if tweet.liked?(current_user)
      tweet.unlike(current_user)
    end

    redirect_to root_path,
                notice: "いいねを削除しました。",
                status: :see_other
  end

  private

  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインしてください。"
    end
  end
end