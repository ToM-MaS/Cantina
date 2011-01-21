class PhoneKeysController < ApplicationController
  # GET /phone_keys
  # GET /phone_keys.xml
  def index
    @phone_keys = PhoneKey.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phone_keys }
    end
  end

  # GET /phone_keys/1
  # GET /phone_keys/1.xml
  def show
    @phone_key = PhoneKey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @phone_key }
    end
  end

  # GET /phone_keys/new
  # GET /phone_keys/new.xml
  def new
    @phone_key = PhoneKey.new
    
    # FIXME - some kind of .find() or .where() here?
    @sip_accounts = SipAccount.order(:name)
    # FIXME - some kind of .find( :phone_model_id => @phone_key.phone_model_key.phone_model_id ) or .where( :phone_model_id => @phone_key.phone_model_key.phone_model_id ) here?
    @phone_model_keys = PhoneModelKey.order(:position)
    @phone_key_function_definitions = PhoneKeyFunctionDefinition.order(:name)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @phone_key }
    end
  end

  # GET /phone_keys/1/edit
  def edit
    @phone_key = PhoneKey.find(params[:id])
    
    # FIXME - some kind of .find() or .where() here?
    @sip_accounts = SipAccount.order(:name)
    # FIXME - some kind of .find( :phone_model_id => @phone_key.phone_model_key.phone_model_id ) or .where( :phone_model_id => @phone_key.phone_model_key.phone_model_id ) here?
    @phone_model_keys = PhoneModelKey.order(:position)
    @phone_key_function_definitions = PhoneKeyFunctionDefinition.order(:name)
    
  end

  # POST /phone_keys
  # POST /phone_keys.xml
  def create
    @phone_key = PhoneKey.new(params[:phone_key])
    
    # FIXME - some kind of .find() or .where() here?
    @sip_accounts = SipAccount.order(:name)
    # FIXME - some kind of .find( :phone_model_id => @phone_key.phone_model_key.phone_model_id ) or .where( :phone_model_id => @phone_key.phone_model_key.phone_model_id ) here?
    @phone_model_keys = PhoneModelKey.order(:position)
    @phone_key_function_definitions = PhoneKeyFunctionDefinition.order(:name)
    
    respond_to do |format|
      if @phone_key.save
        format.html { redirect_to(@phone_key, :notice => 'Phone key was successfully created.') }
        format.xml  { render :xml => @phone_key, :status => :created, :location => @phone_key }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @phone_key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /phone_keys/1
  # PUT /phone_keys/1.xml
  def update
    @phone_key = PhoneKey.find(params[:id])
    
    # FIXME - some kind of .find() or .where() here?
    @sip_accounts = SipAccount.order(:name)
    # FIXME - some kind of .find( :phone_model_id => @phone_key.phone_model_key.phone_model_id ) or .where( :phone_model_id => @phone_key.phone_model_key.phone_model_id ) here?
    @phone_model_keys = PhoneModelKey.order(:position)
    @phone_key_function_definitions = PhoneKeyFunctionDefinition.order(:name)
    
    respond_to do |format|
      if @phone_key.update_attributes(params[:phone_key])
        format.html { redirect_to(@phone_key, :notice => 'Phone key was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @phone_key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_keys/1
  # DELETE /phone_keys/1.xml
  def destroy
    @phone_key = PhoneKey.find(params[:id])
    @phone_key.destroy

    respond_to do |format|
      format.html { redirect_to(phone_keys_url) }
      format.xml  { head :ok }
    end
  end
end
