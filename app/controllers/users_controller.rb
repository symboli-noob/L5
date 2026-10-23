class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "ユーザーを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])

    unless current_user == user
      redirect_to users_path,
                  alert: "ユーザーを削除するには本人のログインが必要です。"
      return
    end

    user.destroy!
    reset_session

    redirect_to users_path,
                notice: "ユーザーを削除しました。",
                status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:uid, :password, :password_confirmation)
  end
end