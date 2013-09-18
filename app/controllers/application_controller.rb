require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
	
	before_filter :set_api_request_format, :if => :api_subdomain?
	
  respond_to :html, :json, :xml

  protect_from_forgery

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound do |exception|
      respond_to do |format|
        format.html {
          flash.now[:error] = 'Record not found'
          render :template => 'site/404', :status => 404
        }
        format.xml  { head 404 }
        format.json { head 404 }
      end
    end
  end

  protected

  def random_sort_clause
    seed = session["#{controller_name}_random_sort_seed"] ||= rand(2147483647)
    direction = %w(asc desc).include?(params[:order]) ? params[:order].upcase : ''
    "RANDOM() #{direction}"
  end

  def clear_random_sort_seed
    session["#{controller_name}_random_sort_seed"] = nil
  end

  def filter_sort_and_paginate(collection, default_order_random = false)
    collection = collection.tagged_with(params[:tag]) if params[:tag].present?

    if params[:column].eql?('random') || (params[:column].nil? && default_order_random)
      collection = collection.order(random_sort_clause)
    else
      clear_random_sort_seed
      begin
        collection = collection.sorty(params)
      rescue HeySorty::ArgumentError => e
        flash[:error] = "Couldn't sort results by invalid sorting parameters."
      end
    end

    if params[:page] == 'all'
      collection.all
    else
      if params[:page] && params[:page].to_i.to_s != params[:page]
        flash[:error]  = "Couldn't paginate results by invalid page number (#{params[:page].strip})."
        params.delete(:page)
      end
      collection.paginate(:page => params[:page], :per_page => params[:per_page] || params[:grid] ? 28 : 30)
    end
  end


  def current_person
    current_user && current_user.person
  end
  helper_method :current_person

  def require_admin!
    authenticate_user! and return unless current_user
    unless current_user.admin?
      flash[:error] = "Access denied."
      redirect_to root_path and return
    end
  end
  
  # Should a login be allowed as a specific user? Used by the AuthenticationsController and views. Stub this in specs!
  def self.allow_login_as_specific_user?
    Rails.env == "development"
  end

  # Wrapper for ApplicationController::allow_login_as_specific_user? because there's no way to stub it. Integration tests can't get to the instance and RSpec's #any_instance is broken.
  def allow_login_as_specific_user?
    return self.class.allow_login_as_specific_user?
  end
  helper_method :allow_login_as_specific_user?

  def page_title(value=nil)
    @page_title = value unless value.nil?

    if @page_title.nil?
      @page_title ||=
        case action_name.to_sym
        when :index
          controller_name.titleize
        when :new, :create
          "New " + controller_name.singularize.humanize.downcase
        when :edit, :update
          "Edit " + controller_name.singularize.humanize.downcase
        when :destroy
          "Destroy " + controller_name.singularize.humanize.downcase
        else
          begin
            get_resource_ivar.name
          rescue Exception => e
            controller_name.singularize.humanize.titleize
          end
        end
    else
      @page_title
    end
  end
  helper_method :page_title
	
	private
	def set_api_request_format
    request.format = :json
  end 

  def api_subdomain?
    request.subdomains.include? 'api' 
  end
end
