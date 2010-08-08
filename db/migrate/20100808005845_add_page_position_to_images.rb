class AddPagePositionToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :page_position, :string
  end

  def self.down
    remove_column :images, :page_position
  end
end