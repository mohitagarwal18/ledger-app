class CreateEntity < ActiveRecord::Migration[6.1]
  def change
    create_table :entities do |t|
      t.integer :entity_type, default: 0, null: false
      t.string :description

      t.timestamps
    end
  end
end