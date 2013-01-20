class Group < ActiveRecord::Base
  include SearchEngine
  has_paper_trail :ignore => [:delta]
  acts_as_taggable_on :tags, :technologies
  sortable :created_at, :desc

	extend FriendlyId
  friendly_id :name, :use => :slugged

  has_attached_file :logo, :styles => { :medium => '220x220', :thumb => '48x48' }, 
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
  }

  default_serialization_options :include => { :projects => {:include => [:tags, :technologies]}, 
                                              :companies => {:include => [:tags, :technologies]},
                                              :members  => {:include => [:tags, :technologies]},
                                              :tags => {},
                                              :technologies => {}}

  has_many :group_projects
  has_many :projects, :through => :group_projects

  has_many :group_memberships
  has_many :members, :through => :group_memberships, :source => :person

  has_many :sponsorships
  has_many :companies, :through => :sponsorships

  validates_presence_of :name

  def clean_address
    if address.nil?
      return address
    end
    return address.gsub(" ", "+").gsub(",", "")
  end

  # Ghetto json method since the default_serialization_options seem broken
  def wwip_json(options={})

    #This conditional is to fix a minor bug where websites lacking
    #http:// at the beginning were trying to link locally and hence were broken
    if self.url[0,3] == 'www'
      self.url = 'http://' + self.url
    end
    return { :company => { 
      :user_id => self.id,
      :Lat => self.latitude,
      :Long => self.longitude,
      :location => self.address,
      :website => self.url,
      :jobs => nil,
      :name => name,
      :category => get_categories,
      :is_group => true
    } }
  end


  def get_categories
    categories = ""

    if self.is_startup
      categories = categories + "startup,"
    end
    if self.is_company
      categories = categories + "company,"
    end
    if self.is_accelerator
      categories = categories + "accelerator,"
    end
    if self.is_investor
      categories = categories + "investor,"
    end
    if self.is_coworking
      categories = categories + "coworking,"
    end
    if self.is_organization
      categories = categories + "organization,"
    end
    if self.is_service
      categories = categories + "service,"
    end

    if categories.length < 1
      return "organization"
    else
      return categories[0, categories.length-1]
    end
  end

end

# == Schema Information
#
# Table name: groups
#
#  id                :integer(4)      not null, primary key
#  name              :string(255)
#  description       :text
#  url               :string(255)
#  mailing_list      :string(255)
#  twitter           :string(255)
#  meeting_info      :text
#  created_at        :datetime
#  updated_at        :datetime
#  logo_url          :string(255)
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer(4)
#  logo_updated_at   :datetime
#  delta             :boolean(1)      default(TRUE), not null
#

