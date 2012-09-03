require 'geocoder'

class Company < ActiveRecord::Base
  include SearchEngine

  # adds geocoding
  geocoded_by :address
  after_validation :geocode

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
                                              :groups => {:include => [:tags, :technologies]},
                                              :employees  => {:include => [:tags, :technologies]},
                                              :tags => {},
                                              :technologies => {}}

  has_many :company_projects
  has_many :projects, :through => :company_projects

  has_many :sponsorships
  has_many :groups, :through => :sponsorships

  has_many :employments
  has_many :employees, :through => :employments, :source => :person

  validates_presence_of :name
  
  def clean_address
    address.gsub(" ", "+").gsub(",", "")
  end

  def map_url
        "http://maps.googleapis.com/maps/api/staticmap?center=#{clean_address}&zoom=13&size=200x220&maptype=roadmap&markers=color:blue%7C#{clean_address}&sensor=false"
  end
  def google_maps_link
    "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=#{clean_address}"
  end
end

  public

  # geocoded?: Behaves like a databse field, but it's actually dynamic
  def geocoded?
    RAILS_DEFAULT_LOGGER.debug "================================="
    RAILS_DEFAULT_LOGGER.debug address
    RAILS_DEFAULT_LOGGER.debug "latitude = #{self.latitude}"
    RAILS_DEFAULT_LOGGER.debug "longitude = #{self.longitude}"
    if (self.latitude && self.longitude) || (self.latitude == -1.0 && self.longitude == -1.0)
      # Lat/Long was already set previously
      RAILS_DEFAULT_LOGGER.debug "CC1: Lat/Long is set"
      return true
    else
      # we'll try geocoding it now
      results = Geocoder.search(clean_address)
      if results.first.nil?
        RAILS_DEFAULT_LOGGER.debug "CC2: Geocoding failed"
        # geocoding failed
        self.latitude = -1.0
        self.longitude = -1.0
        self.save!
        return false
      else
        RAILS_DEFAULT_LOGGER.debug "CC3: Lat/Long is set"
        self.latitude = results.first.latitude
        self.longitude = results.first.longitude
        RAILS_DEFAULT_LOGGER.debug "latitude2 = #{latitude}"
        RAILS_DEFAULT_LOGGER.debug "longitude2 = #{longitude}"
        self.save!
        return true
      end
    end
  end

# == Schema Information
#
# Table name: companies
#
#  id                :integer(4)      not null, primary key
#  name              :string(255)
#  url               :string(255)
#  twitter           :string(255)
#  address           :text
#  description       :text
#  created_at        :datetime
#  updated_at        :datetime
#  logo_url          :string(255)
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer(4)
#  logo_updated_at   :datetime
#  delta             :boolean(1)      default(TRUE), not null
#

