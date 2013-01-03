class MapsController < ApplicationController

  def old
    @companies = Company.all

    respond_to do |format|
      format.html
    end
  end

  # embed: Embed widget
  def embed
    @companies = Company.all

	# turn-off the layout
	render :layout => false
  end

  # The page originally created by bradoyler
  def index
    @companies = Company.all
  end

  # returns the json feed used by the maps
  def wwip_json
    @companies = Company.all
    @groups = Group.all

    ## The next line should work, but doesn't
    # render :json => @companies.as_json(:root => false)
    json = []
    @companies.each do |company|
      if company.geocode_or_return
        json << company.wwip_json
      end
    end
    @groups.each do |group|
      if group.geocode_or_return
        json << group.wwip_json
      end
    end
    render :json => json
  end

end
