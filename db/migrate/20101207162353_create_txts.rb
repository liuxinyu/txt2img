class CreateTxts < ActiveRecord::Migration
  def self.up
    create_table :txts do |t|
      t.string :text
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :txts
  end
end
