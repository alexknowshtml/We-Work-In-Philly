class AddCategoriesToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :is_accelerator, :boolean
    add_column :companies, :is_company, :boolean
    add_column :companies, :is_coworking, :boolean
    add_column :companies, :is_investor, :boolean
    add_column :companies, :is_organization, :boolean
    add_column :companies, :is_service, :boolean
    add_column :companies, :is_startup, :boolean
  end

  def self.down
    remove_column :companies, :is_startup
    remove_column :companies, :is_service
    remove_column :companies, :is_organization
    remove_column :companies, :is_investor
    remove_column :companies, :is_coworking
    remove_column :companies, :is_company
    remove_column :companies, :is_accelerator
  end
end
