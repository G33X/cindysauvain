class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :speaker
      t.string :building
      t.string :address
      t.string :zip
      t.string :city
      t.string :image
      t.text :details
      t.datetime :date_from
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
