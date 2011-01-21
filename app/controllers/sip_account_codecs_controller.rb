class SipAccountCodecsController < ApplicationController
  # GET /sip_account_codecs
  # GET /sip_account_codecs.xml
  def index
    @sip_account_codecs = SipAccountCodec.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sip_account_codecs }
    end
  end

  # GET /sip_account_codecs/1
  # GET /sip_account_codecs/1.xml
  def show
    @sip_account_codec = SipAccountCodec.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sip_account_codec }
    end
  end

  # GET /sip_account_codecs/new
  # GET /sip_account_codecs/new.xml
  def new
    @sip_account_codec = SipAccountCodec.new
    
    @codecs = Codec.all
    # FIXME - some kind of .find() or .where() here?
    @sip_accounts = SipAccount.order(:name)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sip_account_codec }
    end
  end

  # GET /sip_account_codecs/1/edit
  def edit
    @sip_account_codec = SipAccountCodec.find(params[:id])
    
    @codecs = Codec.all
    # FIXME - some kind of .find() or .where() here?
    @sip_accounts = SipAccount.order(:name)
  end

  # POST /sip_account_codecs
  # POST /sip_account_codecs.xml
  def create
    @sip_account_codec = SipAccountCodec.new(params[:sip_account_codec])
    
    @codecs = Codec.all
    # FIXME - some kind of .find() or .where() here?
    @sip_accounts = SipAccount.order(:name)
    
    respond_to do |format|
      if @sip_account_codec.save
        format.html { redirect_to(@sip_account_codec, :notice => 'Sip account codec was successfully created.') }
        format.xml  { render :xml => @sip_account_codec, :status => :created, :location => @sip_account_codec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sip_account_codec.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sip_account_codecs/1
  # PUT /sip_account_codecs/1.xml
  def update
    @sip_account_codec = SipAccountCodec.find(params[:id])
    
    @codecs = Codec.all
    # FIXME - some kind of .find() or .where() here?
    @sip_accounts = SipAccount.order(:name)
    
    respond_to do |format|
      if @sip_account_codec.update_attributes(params[:sip_account_codec])
        format.html { redirect_to(@sip_account_codec, :notice => 'Sip account codec was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sip_account_codec.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sip_account_codecs/1
  # DELETE /sip_account_codecs/1.xml
  def destroy
    @sip_account_codec = SipAccountCodec.find(params[:id])
    @sip_account_codec.destroy

    respond_to do |format|
      format.html { redirect_to(sip_account_codecs_url) }
      format.xml  { head :ok }
    end
  end
end
