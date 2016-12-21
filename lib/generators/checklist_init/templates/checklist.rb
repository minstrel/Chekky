class Checklist < ActiveRecord::Base
  def checkcolor
    if self.complete == true
      "green"
    else
      "grey"
    end
  end
  <%- if false -%>
  <%- # For checkbox items, refer to this later -%>
  def vickie_checkcolor
    if self.vickie == true
      "green"
    else
      "grey"
    end
  end
  <%- end -%>
end
