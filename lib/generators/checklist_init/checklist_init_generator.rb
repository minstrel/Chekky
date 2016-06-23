class ChecklistInitGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  no_tasks do
    # Private Methods here
    def new_field
      name = getname
      type = gettype
      width = getwidth
      puts "You entered: " + " " + [name, type, width].join(" ")
    end
    def getname
      ask("Enter the Name for the new field: ")
    end
    def gettype
      allowedtypes = {1 => :String, 2 => :Checkbox}
      allowedstring = ""
      allowedtypes.each_pair { |key, value| allowedstring << (key.to_s + ") " + value.to_s + "\n") }
      answer = ask("Select field type:\n#{allowedstring}").to_i
      if not allowedtypes.has_key?(answer)
        puts "Invalid field type, please re-enter\n"
        answer = gettype
      end
      answer
    end
    def getwidth
      ask("Enter width (out of 16)")
    end
  end
  def insp
    require './config/environment'
    a = Checklist.new()
    p a.inspect
    p a.class
  end
  def copy_initializer
    template "test.rb", "config/initializers/#{name}.rb"
  end
  def newlist
    new_field
  end
end
