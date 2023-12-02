class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  skip_before_action :users_documents

  def new
  end

  def create
    session_params = params.permit(:username, :password, :authenticity_token, :commit)
    @user = User.find_by(username: session_params[:username])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to documents_path
    else
      flash[:notice] = "Lietotājvārds vai parole nav pareiza"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Jūs esat izrakstījies"
    redirect_to root_path
  end
end
