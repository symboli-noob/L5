class TopController < ApplicationController
  def main
    @tweets = Tweet.includes(:user).order(created_at: :desc)
    @current_user = current_user
  end

  def login_form
  end

  def login
    user = User.find_by(uid: params[:uid])

    if user && user.authenticate(params[:password].to_s)
      reset_session
      session[:login_uid] = user.uid
      redirect_to root_path, notice: "ログインしました。"
    else
      flash.now[:alert] = "ユーザーIDまたはパスワードが違います。"
      render :login_form, status: :unprocessable_entity
    end
  end

  def logout
    reset_session
    redirect_to root_path,
                notice: "ログアウトしました。",
                status: :see_other
  end
end