class MapsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # embed: Embed widget
  def embed
    @companies = Company.all

	# turn-off the layout
	render :layout => false
  end

  # The page created by bradoyler
  def bradoyler
    @companies = Company.all
  end

end
