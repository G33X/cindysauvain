class CreateMedias < ActiveRecord::Migration
  def self.up
    create_table :medias do |t|
      t.string :media_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :medias
  end
end