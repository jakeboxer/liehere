class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.string :text
      t.references :user, :index => true
      t.boolean :truth

      t.timestamps
    end
  end
end
