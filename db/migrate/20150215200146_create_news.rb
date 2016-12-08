class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :title
      t.text :description
      t.text :text
      t.string :type
      t.date :date
      t.string :image
      t.string :video
      t.string :author
      t.integer :likes
      
      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end