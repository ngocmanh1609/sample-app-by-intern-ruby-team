# encoding: utf-8
# Add picture to micropost table
class AddPictureToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :picture, :string
  end
end
