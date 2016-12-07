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
    <%- # Define variable for each field flagged as searchable -%>
    <%- searchfields = [] -%>
    <%- @list.each do |list_item| -%>
      <%- # For strings -%>
      <%- if list_item[:type] = 1 and list_item[:searchable] == true -%>
        <%- name = list_item[:name] -%>
        @<%= name %> = search_params[:<%= name %>]
        @<%= name %> = "%" if @<%= name %> == "" 
        <%- searchfields << name -%>
      <%- end -%>
    <%- end -%>
    <%- # Create the search query -%>
    <%- search_query = searchfields.join(" like ? AND ") + " like ?" -%>
    <%- search_query_fields = (searchfields.map { |field| "@#{field}" }).join(", ")-%>
    @results = Checklist.where("<%= search_query %>", <%= search_query_fields %>)
      render layout: false
      <%- # Reference below from original implementation, if the output from above matches this, we're good -%>
      <%- if false -%>
      @book = search_params[:book]
      @page = search_params[:page]
      @book = "%" if @book == ""
      @page = "%" if @page == ""
      @results = Checklist.where("book like ? AND page like ?", @book, @page) 
      render layout: false
      <%- end -%>
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
    # If completed state has changed, see callback for behavior.
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
  <%- # Collect the fields that the user wants searchable, as well as all the fields, and populate the search_params and post_params accordingly -%>
  <%- search_params_permit = [] -%>
  <%- post_params_permit = ["complete"] -%>
  <%- @list.each do |list_item| -%>
    <%- if list_item[:searchable] == true -%>
      <%- search_params_permit << list_item[:name] -%>
    <%- end -%>
    <%- post_params_permit << list_item[:name] -%>
  <%- end -%>
    def search_params
      params.permit(<%= (search_params_permit.map { |field| ":#{field}" }).join(", ") %>)
    end
    def post_params
      params.require(:checklist).permit(<%= (post_params_permit.map { |field| ":#{field}" }).join(", ") %>)
    end
  def search_params
    params.permit(:book, :page)
  end
  def post_params
    params.require(:checklist).permit(:book, :page, :note, :vickie, :complete)
  end
end
