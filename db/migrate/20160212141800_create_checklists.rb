class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.text :book
      t.text :page
      t.text :note
      t.boolean :complete, :default => false

      t.timestamps null: false
    end
  end
end
