class AddAddressToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :address1, :string
    add_column :people, :address2, :string
    add_column :people, :zipcode, :string
  end

  def self.down
    remove_column :people, :zipcode
    remove_column :people, :address2
    remove_column :people, :address1
  end
end
