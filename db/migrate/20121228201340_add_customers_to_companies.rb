class AddCustomersToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :customer1, :string
    add_column :companies, :customer_url1, :string
    add_column :companies, :customer2, :string
    add_column :companies, :customer_url2, :string
    add_column :companies, :customer3, :string
    add_column :companies, :customer_url3, :string
  end

  def self.down
    remove_column :companies, :customer_url3
    remove_column :companies, :customer3
    remove_column :companies, :customer_url2
    remove_column :companies, :customer2
    remove_column :companies, :customer_url1
    remove_column :companies, :customer1
  end
end
