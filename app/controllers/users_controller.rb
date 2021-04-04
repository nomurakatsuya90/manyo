class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show]

  def new
    if logged_in?
      redirect_to user_path(current_user.id)
      flash[:notice] = 'すでにログインしています'
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: "登録しました"
    else
      render :new
    end
  end

  def show
    if current_user.id == @user.id
      @user = User.find(params[:id])
    else
      redirect_to tasks_path, notice: '自分以外のユーザのプロフィールは閲覧できません'
    end
  end

    private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    def set_user
      @user = User.find(params[:id])
    end
end
