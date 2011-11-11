class MapsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
end