class AddLongtextToTxt < ActiveRecord::Migration
  def self.up
    add_column :txts, :longtext, :text
  end

  def self.down
    remove_column :txts, :longtext
  end
end
