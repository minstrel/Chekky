require 'test_helper'
require 'generators/checklist_init/checklist_init_generator'

class ChecklistInitGeneratorTest < Rails::Generators::TestCase
  tests ChecklistInitGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
