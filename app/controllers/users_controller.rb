class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :users_documents

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to documents_path
    else
      flash[:error] = "Lietotājs nav izveidots. Lūdzu mēģiniet vēlreiz"
      redirect_to new_user_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
