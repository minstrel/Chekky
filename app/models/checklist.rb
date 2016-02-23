class Checklist < ActiveRecord::Base
  def checkcolor
    if self.complete == true
      "green"
    else
      "grey"
    end
  end
end
