class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price_cents, null: false
      t.string :price_currency, null: false, default: 'JPY'

      t.timestamps
    end
  end
end
