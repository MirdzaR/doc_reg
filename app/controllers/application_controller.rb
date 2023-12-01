class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :users_documents

  helper_method :current_user

  def require_login
    redirect_to new_session_path unless session.include? :user_id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def users_documents
    @document = Document.find_by_id(params[:id])
    if @document.present?
      redirect_to documents_path unless @document.user == current_user
    else
      redirect_to documents_path
    end
  end
end
