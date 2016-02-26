class AddVickieToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :vickie, :boolean, :default => false
  end
end
