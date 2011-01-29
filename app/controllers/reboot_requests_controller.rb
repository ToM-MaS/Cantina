class RebootRequestsController < ApplicationController
  # GET /reboot_requests
  # GET /reboot_requests.xml
  def index
    @reboot_requests = RebootRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reboot_requests }
    end
  end

  # GET /reboot_requests/1
  # GET /reboot_requests/1.xml
  def show
    @reboot_request = RebootRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reboot_request }
    end
  end

  # GET /reboot_requests/new
  # GET /reboot_requests/new.xml
  def new
    @reboot_request = RebootRequest.new
    @phones = Phone.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reboot_request }
    end
  end

  # POST /reboot_requests
  # POST /reboot_requests.xml
  def create
    @reboot_request = RebootRequest.new(params[:reboot_request])

    # TODO Idealerweise wird ein Reboot-Request im normalen REST Model vollzogen. Also als create und nicht als reboot im phone controller.
    
    respond_to do |format|
      if @reboot_request.save
        format.html { redirect_to(@reboot_request, :notice => 'Reboot request was successfully created.') }
        format.xml  { render :xml => @reboot_request, :status => :created, :location => @reboot_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reboot_request.errors, :status => :unprocessable_entity }
      end
    end
  end
end
