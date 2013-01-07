class AddCategoriesToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :is_accelerator, :boolean
    add_column :groups, :is_company, :boolean
    add_column :groups, :is_coworking, :boolean
    add_column :groups, :is_investor, :boolean
    add_column :groups, :is_organization, :boolean
    add_column :groups, :is_service, :boolean
    add_column :groups, :is_startup, :boolean
  end

  def self.down
    remove_column :groups, :is_startup
    remove_column :groups, :is_service
    remove_column :groups, :is_organization
    remove_column :groups, :is_investor
    remove_column :groups, :is_coworking
    remove_column :groups, :is_company
    remove_column :groups, :is_accelerator
  end
end
