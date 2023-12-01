class DocumentsController < ApplicationController
  skip_before_action :users_documents, only: [:index, :new, :create, :remove_attachment]

  def index
    @documents = if params[:start_date].present? || params[:end_date].present?
      start_date = Date.parse(params[:start_date]) if params[:start_date].present?
      end_date = Date.parse(params[:end_date]) if params[:end_date].present?

      search_results(start_date, end_date)
    else
      Document.where(user_id: current_user.id)
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to @document
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update(document_params)
      redirect_to @document
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @attachments = ActiveStorage::Attachment.where(record_id: params[:id])
    @attachments.each do |attachment|
      @attachment = ActiveStorage::Attachment.find(attachment.id)
      @attachment.purge_later
    end
    @document.destroy

    redirect_to documents_path
  end

  def remove_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge_later
    redirect_back(fallback_location: request.referrer)
  end

  private

  def document_params
    params.require(:document).permit(:title, :body, :user_id,  :start_date, :end_date, attachments: []).select {|x,v| v.present?}
  end

  def search_results(start_date, end_date)
    if start_date.present? && !end_date.present?
      Document.where(user_id: current_user.id).where("created_at >= ?", start_date)
    elsif !start_date.present? && end_date.present?
      Document.where(user_id: current_user.id).where("created_at <= ?", end_date.end_of_day)
    else
      Document.where(user_id: current_user.id).where("created_at >= ? AND created_at <= ?", start_date, end_date.end_of_day)
    end
  end
end
