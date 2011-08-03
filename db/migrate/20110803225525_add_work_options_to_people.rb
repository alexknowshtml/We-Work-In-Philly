class AddWorkOptionsToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :contact_gigs, :integer
    add_column :people, :contact_jobs, :integer
    add_column :people, :contact_recruiter, :integer
  end

  def self.down
    remove_column :people, :contact_recruiter
    remove_column :people, :contact_jobs
    remove_column :people, :contact_gigs
  end
end
