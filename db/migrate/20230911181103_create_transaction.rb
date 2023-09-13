class CreateTransaction < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :activity_id, limit: 8, unsigned: true  # Use 64-bit unsigned integer for activity_id
      t.timestamp :date
      t.integer :transaction_type, null: false # Use enum for type
      t.string :method
      t.float :amount
      t.float :balance
      t.json :source
      t.integer :sequence_id
      t.references :entity, foreign_key: true
      t.timestamps
    end
    add_index :transactions, :activity_id, unique: true
  end
end