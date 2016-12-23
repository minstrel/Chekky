class ChecklistInitGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  no_tasks do
    # Private Methods here
    def new_field
      name = getname
      type = gettype
      width = getwidth
      searchable = in_search
      {:name => name, :type => type, :width => width.to_i, :searchable => searchable}
    end
    def getname
      ask("Enter the Name for the new field: ").downcase
    end
    def gettype
      allowedtypes = {1 => :String}
      allowedstring = ""
      allowedtypes.each_pair { |key, value| allowedstring << (key.to_s + ") " + value.to_s + "\n") }
      answer = ask("Select field type:\n#{allowedstring}").to_i
      if not allowedtypes.has_key?(answer)
        say("Invalid field type, please re-enter")
        answer = gettype
      end
      answer
    end
    def getwidth
      ask("Enter width (out of 16)")
    end
    def in_search
      yes?("Make field searchable?")
    end
  end
  # Methods below here gets executed in order
  def insp
    require './config/environment'
    a = Checklist.new()
    p a.inspect
    p a.class
  end
#  def copy_initializer
#    @stuff = 123
#    template "test.rb", "config/initializers/#{name}.rb"
#  end
  def newlist
    say("Create a new checklist", :green)
    @list = []
    while yes?("Enter a new field?", :yellow)
      @list << new_field
    end
    # app/controllers
    template "checklists_controller.rb", "config/initializers/checklists_controller.rb"
    # app/views/layouts
    template "tabs.html.erb", "config/initializers/tabs.html.erb"
    # app/views/checklists
    template "_newitem.html.erb", "config/initializers/_newitem.html.erb"
    template "create.js.erb", "config/initializers/create.js.erb"
    template "edit.html.erb", "config/initializers/edit.html.erb"
    template "search.html.erb", "config/initializers/search.html.erb"
    template "search_results.html.erb", "config/initializers/search_results.html.erb"
    # app/assets/javascripts
    template "checklists.js.erb", "config/initializers/checklists.js"
    # app/models
    template "checklist.rb", "config/initializers/checklist.rb"
  end
end
