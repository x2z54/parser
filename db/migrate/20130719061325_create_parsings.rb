class CreateParsings < ActiveRecord::Migration
  def change
    create_table :parsings do |t|
      t.string :Page
      t.string :title
      t.string :link
      t.decimal :num
      t.text :body

      t.timestamps
    end
  end
end
