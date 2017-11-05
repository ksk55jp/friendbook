class AddTitleToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :title, :string
    add_column :pictures, :alt, :string
  end
end
