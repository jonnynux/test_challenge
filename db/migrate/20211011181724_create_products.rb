class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_code, null: false, unique: true
      t.string :name, null: false, unique: true
      t.float :price, default: 0

      t.timestamps
    end
  end
end
