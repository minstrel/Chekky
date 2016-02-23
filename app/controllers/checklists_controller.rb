class ChecklistsController < ApplicationController

  def index
    @checklist_item = Checklist.new
  end

  def not_completed
    @checklist_items = Checklist.where(complete: false)
    @checkmark_color = "grey"
    @refresh_tab = "not_completed"
    render :edit, layout: "tabs"
  end

  def completed
    @checklist_items = Checklist.where(complete: true)
    @checkmark_color = "green"
    @refresh_tab = "completed"
    render :edit, layout: "tabs"
  end

  def search
    render :search, layout: false
  end

  def search_results
    @book = search_params[:book]
    @page = search_params[:page]
    @book = "%" if @book == ""
    @page = "%" if @page == ""
    @results = Checklist.where("book like ? AND page like ?", @book, @page) 
    render layout: false
  end

  def edit
    @checklist_items = Checklist.where(id: params[:id])
    @checkmark_color = "grey"
    render layout: false
  end

  def create
    @checklist_item = Checklist.new(post_params)

    respond_to do |format|
      if @checklist_item.save
        format.js
      end
    end
  end

  def purge
    Checklist.where(complete: true).delete_all
    render nothing: true
  end

  def update
    @checklist_item = Checklist.find(params[:id])
    @checklist_item.toggle :complete
    respond_to do |format|
      if @checklist_item.save
        format.js
      end
    end
  end

  private
  def search_params
    params.permit(:book, :page)
  end
  def post_params
    params.require(:checklist).permit(:book, :page, :note, :complete)
  end
end
