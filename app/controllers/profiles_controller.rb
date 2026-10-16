class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    if @current_user.profile
      redirect_to edit_profile_path
      return
    end

    @profile = @current_user.build_profile
  end

  def create
    if @current_user.profile
      redirect_to profile_path, alert: "プロフィールは登録済みです。"
      return
    end

    @profile = @current_user.build_profile(profile_params)

    if @profile.save
      redirect_to profile_path, notice: "プロフィールを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path,
                  notice: "プロフィールを更新しました。",
                  status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy!

    redirect_to root_path,
                notice: "プロフィールを削除しました。",
                status: :see_other
  end

  private

  def require_login
    @current_user = User.find_by(uid: session[:login_uid])

    unless @current_user
      redirect_to login_path, alert: "ログインしてください。"
    end
  end

  def set_profile
    @profile = @current_user.profile

    unless @profile
      redirect_to new_profile_path, alert: "プロフィールを登録してください。"
    end
  end

  def profile_params
    params.require(:profile).permit(:message)
  end
end