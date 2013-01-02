class AddJobsUrlToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :jobs_url, :string
  end

  def self.down
    remove_column :companies, :jobs_url
  end
end
