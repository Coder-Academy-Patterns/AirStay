class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :trip, foreign_key: true, null: false
      t.text :content, null: false
      t.decimal :rating, precision: 2, scale: 1, null: false
      t.boolean :from_guest, null: false

      t.timestamps
    end
  end
end
