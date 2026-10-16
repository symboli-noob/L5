class TweetsController < ApplicationController
  before_action :require_login

  def create
    tweet = @current_user.tweets.build(tweet_params)

    if tweet.save
      redirect_to root_path, notice: "投稿しました。"
    else
      redirect_to root_path,
                  alert: "投稿できませんでした。本文を入力してください。"
    end
  end

  def destroy
    tweet = @current_user.tweets.find_by(id: params[:id])

    unless tweet
      redirect_to root_path, alert: "削除できる投稿が見つかりません。"
      return
    end

    tweet.destroy!
    redirect_to root_path,
                notice: "投稿を削除しました。",
                status: :see_other
  end

  private

  def require_login
    @current_user = User.find_by(uid: session[:login_uid])

    unless @current_user
      redirect_to login_path, alert: "ログインしてください。"
    end
  end

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end