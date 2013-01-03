class AddAddressToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :address, :text
  end

  def self.down
    remove_column :groups, :address
  end
end
