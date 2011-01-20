class ProvisioningLogEntriesController < ApplicationController
  # GET /provisioning_log_entries
  # GET /provisioning_log_entries.xml
  def index
    @provisioning_log_entries = ProvisioningLogEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @provisioning_log_entries }
    end
  end

  # GET /provisioning_log_entries/1
  # GET /provisioning_log_entries/1.xml
  def show
    @provisioning_log_entry = ProvisioningLogEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @provisioning_log_entry }
    end
  end
end
