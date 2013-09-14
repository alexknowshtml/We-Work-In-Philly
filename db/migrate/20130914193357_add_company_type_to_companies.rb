class AddCompanyTypeToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :company_type, :string
  end

  def self.down
    remove_column :companies, :company_type
  end
end
