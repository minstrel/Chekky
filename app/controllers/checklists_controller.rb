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
    @checklist_items = Checklist.where(complete: true).limit(50).order('created_at desc')
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

  def update
    @checklist_item = Checklist.find(params[:id])
    # Are we changing the completed state or something else?
    @complete_changed = false
    @post_complete = case post_params["complete"]
                     when "0"
                       false
                     else
                       true
                     end
    if @post_complete == @checklist_item.complete
      @complete_changed = false
    else
      @complete_changed = true
    end 
    respond_to do |format|
      if @checklist_item.update(post_params)
        format.js
      end
    end
  end

  private
  def search_params
    params.permit(:book, :page)
  end
  def post_params
    params.require(:checklist).permit(:book, :page, :note, :vickie, :complete)
  end
end
