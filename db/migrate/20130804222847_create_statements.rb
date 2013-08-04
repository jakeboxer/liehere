class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.string :text, :null => false, :default => ''
      t.references :user, :index => true
      t.boolean :lie, :null => false, :default => false

      t.timestamps
    end
  end
end
