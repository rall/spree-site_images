class AddPagePositionToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :page_position, :string
  end

  def self.down
    remove_column :assets, :page_position
  end
end