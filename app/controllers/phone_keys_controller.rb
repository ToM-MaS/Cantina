class PhoneKeysController < ApplicationController
  # GET /phone_keys
  # GET /phone_keys.xml
  def index
    @sip_account = SipAccount.find(params[:sip_account_id])
    @phone_keys = @sip_account.phone_keys

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
    @sip_account = SipAccount.find(params[:sip_account_id])
    @phone_key = @sip_account.phone_keys.build
    
    @phone_model_keys = @sip_account.undefined_phone_model_keys
    @phone_key_function_definitions = @phone_model_keys.collect {|phone_model_key| phone_model_key.phone_key_function_definitions}.flatten.uniq
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @phone_key }
    end
  end

  # GET /phone_keys/1/edit
  def edit
    @sip_account = SipAccount.find(params[:sip_account_id])
    @phone_key = PhoneKey.find(params[:id])

    @phone_model_keys = @sip_account.undefined_phone_model_keys << @phone_key.phone_model_key
    @phone_key_function_definitions = @phone_model_keys.collect {|phone_model_key| phone_model_key.phone_key_function_definitions}.flatten.uniq

    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml => @phone_key }
    end
  end

  # POST /phone_keys
  # POST /phone_keys.xml
  def create
    @sip_account = SipAccount.find(params[:sip_account_id])
    @phone_key = @sip_account.phone_keys.build(params[:phone_key])
    
    respond_to do |format|
      if @phone_key.save
        format.html { redirect_to(@sip_account, :notice => 'Phone key was successfully created.') }
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
    
    respond_to do |format|
      if @phone_key.update_attributes(params[:phone_key])
        format.html { redirect_to(@phone_key.sip_account, :notice => 'Phone key was successfully updated.') }
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
      format.html { redirect_to(@phone_key.sip_account) }
      format.xml  { head :ok }
    end
  end
end
