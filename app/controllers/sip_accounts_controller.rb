class SipAccountsController < ApplicationController
  # GET /sip_accounts
  # GET /sip_accounts.xml
  def index
    #TODO Add tests to ensure that the search parameters really work.
    if params[:auth_user]
      # GET /sip_accounts(.fmt)?auth_user={auth_user}
      @sip_accounts = SipAccount.where('auth_user'=> params[:auth_user])
    elsif params[:name] 
      # GET /sip_accounts(.fmt)?name={name}
      @sip_accounts = SipAccount.where('name' => params[:name])
    elsif params[:phone_id].blank?
      # GET /sip_accounts
      @sip_accounts = SipAccount.all
    else
      # GET /phones/{phone_id}/sip_accounts
      @sip_accounts = Phone.find(params[:phone_id]).sip_accounts
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sip_accounts }
    end
  end
  
  # GET /sip_accounts/1
  # GET /sip_accounts/1.xml
  def show
    @sip_account = SipAccount.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sip_account }
    end
  end
  
  # GET /sip_accounts/new
  # GET /sip_accounts/new.xml
  def new
    @sip_account = SipAccount.new
    @sip_account.phone_id = params[:phone_id]
    
    @phones = Phone.order(:mac_address)
    @dtmf_modes = [ 'rfc2833', 'inband', 'info' ]
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sip_account }
    end
  end
  
  # GET /sip_accounts/1/edit
  def edit
    @sip_account = SipAccount.find(params[:id])
    
    @phones = Phone.order(:mac_address)
    @dtmf_modes = [ 'rfc2833', 'inband', 'info' ]
  end
  
  # POST /sip_accounts
  # POST /sip_accounts.xml
  def create
    @sip_account = SipAccount.new(params[:sip_account])
    
    @phones = Phone.order(:mac_address)
    @dtmf_modes = [ 'rfc2833', 'inband', 'info' ]
    
    respond_to do |format|
      if @sip_account.save
        format.html { redirect_to(@sip_account.phone, :notice => 'Sip account was successfully created.') }
        format.xml  { render :xml => @sip_account, :status => :created, :location => @sip_account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sip_account.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /sip_accounts/1
  # PUT /sip_accounts/1.xml
  def update
    @sip_account = SipAccount.find(params[:id])
    
    @phones = Phone.order(:mac_address)
    @dtmf_modes = [ 'rfc2833', 'inband', 'info' ]
    
    respond_to do |format|
      if @sip_account.update_attributes(params[:sip_account])
        format.html { redirect_to(@sip_account, :notice => 'Sip account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sip_account.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /sip_accounts/1
  # DELETE /sip_accounts/1.xml
  def destroy
    @sip_account = SipAccount.find(params[:id])
    @sip_account.destroy
    
    respond_to do |format|
      format.html { redirect_to(sip_accounts_url) }
      format.xml  { head :ok }
    end
  end
end
