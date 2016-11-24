class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :guest, foreign_key: { to_table: :users }
      t.references :listing, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
