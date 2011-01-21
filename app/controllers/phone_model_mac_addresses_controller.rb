class PhoneModelMacAddressesController < ApplicationController
  # GET /phone_model_mac_addresses
  # GET /phone_model_mac_addresses.xml
  def index
    @phone_model_mac_addresses = PhoneModelMacAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phone_model_mac_addresses }
    end
  end

  # GET /phone_model_mac_addresses/1
  # GET /phone_model_mac_addresses/1.xml
  def show
    @phone_model_mac_address = PhoneModelMacAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @phone_model_mac_address }
    end
  end

  # GET /phone_model_mac_addresses/new
  # GET /phone_model_mac_addresses/new.xml
  def new
    @phone_model_mac_address = PhoneModelMacAddress.new
    
    @phone_models = PhoneModel.order( :manufacturer_id, :name )
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @phone_model_mac_address }
    end
  end

  # GET /phone_model_mac_addresses/1/edit
  def edit
    @phone_model_mac_address = PhoneModelMacAddress.find(params[:id])
    
    @phone_models = PhoneModel.order( :manufacturer_id, :name )
  end

  # POST /phone_model_mac_addresses
  # POST /phone_model_mac_addresses.xml
  def create
    @phone_model_mac_address = PhoneModelMacAddress.new(params[:phone_model_mac_address])
    
    @phone_models = PhoneModel.order( :manufacturer_id, :name )
    
    respond_to do |format|
      if @phone_model_mac_address.save
        format.html { redirect_to(@phone_model_mac_address, :notice => 'Phone model mac address was successfully created.') }
        format.xml  { render :xml => @phone_model_mac_address, :status => :created, :location => @phone_model_mac_address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @phone_model_mac_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /phone_model_mac_addresses/1
  # PUT /phone_model_mac_addresses/1.xml
  def update
    @phone_model_mac_address = PhoneModelMacAddress.find(params[:id])
    
    @phone_models = PhoneModel.order( :manufacturer_id, :name )
    
    respond_to do |format|
      if @phone_model_mac_address.update_attributes(params[:phone_model_mac_address])
        format.html { redirect_to(@phone_model_mac_address, :notice => 'Phone model mac address was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @phone_model_mac_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_model_mac_addresses/1
  # DELETE /phone_model_mac_addresses/1.xml
  def destroy
    @phone_model_mac_address = PhoneModelMacAddress.find(params[:id])
    @phone_model_mac_address.destroy

    respond_to do |format|
      format.html { redirect_to(phone_model_mac_addresses_url) }
      format.xml  { head :ok }
    end
  end
end
